program test_3

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%list_compilers(language_id='fortran')

end program test_3

