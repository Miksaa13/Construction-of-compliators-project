#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Constants.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/Local.h"
#include <vector>
using namespace llvm;

namespace {

// Rekurzivno silazi kroz lanac iste asocijativne operacije (Add ili Mul):
// promenljive stavlja u Leaves, konstante sazima u ConstAcc (Combine ih spaja),
// i broji koliko je konstanti nadjeno.
void collectChainOperands(Value *V, Instruction::BinaryOps Opcode,
                           std::vector<Value*> &Leaves, APInt &ConstAcc,
                           unsigned &NumConstants) {
  if (auto *BinOp = dyn_cast<BinaryOperator>(V)) {
    if (BinOp->getOpcode() == Opcode && BinOp->hasOneUse()) {
      collectChainOperands(BinOp->getOperand(0), Opcode, Leaves, ConstAcc, NumConstants);
      collectChainOperands(BinOp->getOperand(1), Opcode, Leaves, ConstAcc, NumConstants);
      return;
    }
  }
  if (auto *CI = dyn_cast<ConstantInt>(V)) {
    if (Opcode == Instruction::Add)
      ConstAcc += CI->getValue();
    else // Instruction::Mul
      ConstAcc *= CI->getValue();
    NumConstants++;
    return;
  }
  Leaves.push_back(V);
}

  struct OurRePass : public FunctionPass {
    static char ID;
    OurRePass() : FunctionPass(ID) {}

    // Obradjuje jedan lanac (Add ili Mul) sa vrhom u BinOp. Vraca true ako je
    // nesto izmenjeno.
    bool processChain(BinaryOperator *BinOp, Instruction::BinaryOps Opcode) {
      // Obradjujemo samo "vrh" lanca (rezultat se ne koristi u jos jednoj
      // instrukciji iste operacije)
      for (User *U : BinOp->users()) {
        if (auto *UserBinOp = dyn_cast<BinaryOperator>(U)) {
          if (UserBinOp->getOpcode() == Opcode)
            return false;
        }
      }

      std::vector<Value*> Leaves;
      unsigned BitWidth = BinOp->getType()->getIntegerBitWidth();
      APInt ConstAcc(BitWidth, (Opcode == Instruction::Add) ? 0 : 1);
      unsigned NumConstants = 0;
      collectChainOperands(BinOp, Opcode, Leaves, ConstAcc, NumConstants);

      // Isplati se samo ako imamo bar 2 konstante da ih sazmemo u jednu
      if (NumConstants < 2)
        return false;

      bool IsAdd = (Opcode == Instruction::Add);
      APInt Identity(BitWidth, IsAdd ? 0 : 1);//neutralni element za sabiranje ili mnozenje
      bool ConstMattersToKeep = (ConstAcc != Identity);

      errs() << "OurRePass: sazimam " << NumConstants << " konstante ("
             << (IsAdd ? "ADD" : "MUL") << ") u lancu koji pocinje sa "
             << *BinOp << "\n";

      IRBuilder<> Builder(BinOp);
      Value *NewVal = Leaves.empty()
                         ? ConstantInt::get(BinOp->getType(), ConstAcc)
                         : Leaves[0];

      for (size_t i = 1; i < Leaves.size(); ++i)
        NewVal = IsAdd ? Builder.CreateAdd(NewVal, Leaves[i], "reassoc")
                       : Builder.CreateMul(NewVal, Leaves[i], "reassoc");

      if (!Leaves.empty() && ConstMattersToKeep)
        NewVal = IsAdd
                   ? Builder.CreateAdd(NewVal, ConstantInt::get(BinOp->getType(), ConstAcc), "reassoc.const")
                   : Builder.CreateMul(NewVal, ConstantInt::get(BinOp->getType(), ConstAcc), "reassoc.const");

      BinOp->replaceAllUsesWith(NewVal);
      RecursivelyDeleteTriviallyDeadInstructions(BinOp);
      return true;
    }

    bool runOnFunction(Function &F) override {
      bool Changed = false;

      for (auto &BB : F) {
        for (auto It = BB.begin(); It != BB.end(); ) {
          Instruction *Inst = &*It++; // pomeramo iterator PRE eventualnih izmena(brisanja)
          //na vezbama 4.nedleja 3.cas 
          
          auto *BinOp = dyn_cast<BinaryOperator>(Inst);
          if (!BinOp)
            continue;

          if (BinOp->getOpcode() == Instruction::Add) {
            if (processChain(BinOp, Instruction::Add))
              Changed = true;
          } else if (BinOp->getOpcode() == Instruction::Mul) {
            if (processChain(BinOp, Instruction::Mul))
              Changed = true;
          }
        }
      }

      return Changed;
    }
  };
}

char OurRePass::ID = 0;
static RegisterPass<OurRePass> X("our-repass", "Our RePass",
                                 false /* Only looks at CFG */,
                                 false /* Analysis Pass */);