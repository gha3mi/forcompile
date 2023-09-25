program test_7

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%set_source("&
      int main() { return 0; }&
      ")
   call ce%set_compiler_id('g82')

   call ce%options%set_userArguments('-O3')
   call ce%options%set_compilerOptions(skipAsm=.false., executorRequest=.false.)
   call ce%options%set_filters(&
      binary=.false.,&
      binaryObject=.false.,&
      commentOnly=.true.,&
      demangle=.true.,&
      directives=.true.,&
      execute=.true.,&
      intel=.true.,&
      labels=.true.,&
      libraryCode=.false.,&
      trim=.false.,&
      debugCalls=.false.)
   call ce%options%set_tools(id='clangtidytrunk', args='-checks=*')
   call ce%options%set_libraries(id='range-v3', version='trunk')
   call ce%options%set_libraries(id='fmt', version='400')

   call ce%set_lang('c++')
   call ce%set_allowStoreCodeDebug(.true.)

   call ce%compile()
   call ce%finalize()

end program test_7

