program test_7

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%set_source("&
      program hello;&
      write(*,*) 'Hello World';&
      end program hello&
      ")

   call ce%set_compiler_id('gfortran132')

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

   call ce%set_lang('fortran')
   call ce%set_allowStoreCodeDebug(.true.)

   call ce%compile()

   call ce%finalize()

end program test_7

