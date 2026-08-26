#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Constants.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/Support/raw_ostream.h"
#include <vector>
#include "llvm/Transforms/Utils.h"


using namespace llvm;

namespace {

    class LICM : public FunctionPass {
    public:
        static char ID;
        LICM() : FunctionPass(ID) {}

        bool runOnFunction(Function &F) override;
        void getAnalysisUsage(AnalysisUsage &AU) const override;

    private:
        bool processLoopAndSubloops(Loop *L);
        bool runOnLoop(Loop *L);
        bool isCandidateOpcode(Instruction *I) const;
        bool isLoopInvariantInst(Instruction *I, Loop *L, const SmallPtrSetImpl<Instruction *> &Invariant) const;
    };

}

char LICM::ID = 0;


void LICM::getAnalysisUsage(AnalysisUsage &AU) const {
    AU.addRequired<LoopInfoWrapperPass>();
    AU.addRequiredID(LoopSimplifyID);
    AU.setPreservesCFG();
}

bool LICM::runOnFunction(Function &F) {
    if (F.isDeclaration())
        return false;

    LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
    bool Changed = false;
    for (Loop *L : LI)
        Changed |= processLoopAndSubloops(L);

    return Changed;
}

bool LICM::processLoopAndSubloops(Loop *L) {
    bool Changed = false;
    for (Loop *SubL : L->getSubLoops())
        Changed |= processLoopAndSubloops(SubL);
    Changed |= runOnLoop(L);
    return Changed;
}

bool LICM::isCandidateOpcode(Instruction *I) const {
    switch (I->getOpcode()) {
    case Instruction::Add:
    case Instruction::Sub:
    case Instruction::Mul:
    case Instruction::And:
    case Instruction::Or:
    case Instruction::Xor:
    case Instruction::ICmp:
        return true;
    default:
        return false;
    }
}

bool LICM::isLoopInvariantInst(Instruction *I, Loop *L, const SmallPtrSetImpl<Instruction *> &Invariant) const {

    if (!isCandidateOpcode(I))
        return false;

    for (Use &U : I->operands()) {
        Value *Op = U.get();

        if (isa<Constant>(Op))
            continue;

        if (Instruction *OpInst = dyn_cast<Instruction>(Op)) {
            if (!L->contains(OpInst->getParent()))
                continue;
            if (Invariant.count(OpInst))
                continue;
            return false;
        }
    }
    return true;
}


bool LICM::runOnLoop(Loop *L) {
    BasicBlock *Preheader = L->getLoopPreheader();
    if (!Preheader)
        return false;

    SmallPtrSet<Instruction *, 16> Invariant;
    std::vector<Instruction *> HoistOrder;

    bool ChangedThisPass = true;
    while (ChangedThisPass) {
        ChangedThisPass = false;
        for (BasicBlock *BB : L->blocks()) {
            for (Instruction &I : *BB) {
                if (Invariant.count(&I))
                    continue;
                if (isLoopInvariantInst(&I, L, Invariant)) {
                    Invariant.insert(&I);
                    HoistOrder.push_back(&I);
                    ChangedThisPass = true;
                }
            }
        }
    }

    if (HoistOrder.empty())
        return false;

    Instruction *InsertPt = Preheader->getTerminator();
    for (Instruction *I : HoistOrder)
        I->moveBefore(InsertPt);

    errs() << "Hositovano " << HoistOrder.size() << " instrukcija u preheder petlje '" << L->getHeader()->getName() << "'\n";

    return true;
}

static RegisterPass<LICM> X("my-licm", "Custom loop invariant code motion pass", false ,false);