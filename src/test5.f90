program test_5

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%list_libraries(language_id='fortran')

end program test_5

