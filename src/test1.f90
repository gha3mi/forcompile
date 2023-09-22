program test_1

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%list_languages()

end program test_1

