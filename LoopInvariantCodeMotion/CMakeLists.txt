add_llvm_library( LLVMLoopInvariantCodeMotion MODULE BUILDTREE_ONLY
        LICM.cpp

        DEPENDS
        intrinsics_gen
        PLUGIN_TOOL
        opt
)