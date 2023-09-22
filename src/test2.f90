program test_2

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%list_compilers()

end program test_2

