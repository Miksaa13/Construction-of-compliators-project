add_llvm_library( LLVMOurRePass MODULE BUILDTREE_ONLY
  OurRePass.cpp

  DEPENDS
  intrinsics_gen
  PLUGIN_TOOL
  opt
  )
