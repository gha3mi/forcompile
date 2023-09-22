module forcompile

   implicit none

   private
   public :: compiler_explorer

   !===============================================================================
   !> author: Seyed Ali Ghasemi
   type :: compiler_explorer
      character(len=19) :: api_url = "https://godbolt.org"
   contains
      procedure :: list_languages
      procedure :: list_compilers
      procedure :: list_libraries
      procedure :: list_formatters
   end type compiler_explorer
   !===============================================================================

contains

   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine list_languages(this)
      use http, only: response_type, request
      class(compiler_explorer), intent(inout) :: this
      type(response_type)                     :: response

      response = request(url=this%api_url//'/api/languages')
      if(.not. response%ok) then
         print *,'Error message : ', response%err_msg
      else
         print *, 'Response Content : ', response%content
      end if
   end subroutine list_languages
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine list_compilers(this, language_id)
      use http, only: response_type, request
      class(compiler_explorer), intent(inout) :: this
      character(len=*), intent(in), optional  :: language_id
      type(response_type)                     :: response

      if (present(language_id)) then
         response = request(url=this%api_url//'/api/compilers/'//trim(language_id))
      else
         response = request(url=this%api_url//'/api/compilers')
      end if
      if(.not. response%ok) then
         print *,'Error message : ', response%err_msg
      else
         print *, 'Response Content : ', response%content
      end if
   end subroutine list_compilers
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine list_libraries(this, language_id)
      use http, only: response_type, request
      class(compiler_explorer), intent(inout) :: this
      character(len=*), intent(in), optional  :: language_id
      type(response_type)                     :: response

      if (present(language_id)) then
         response = request(url=this%api_url//'/api/libraries/'//trim(language_id))
      else
         response = request(url=this%api_url//'/api/libraries')
      end if
      if(.not. response%ok) then
         print *,'Error message : ', response%err_msg
      else
         print *, 'Response Content : ', response%content
      end if
   end subroutine list_libraries
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine list_formatters(this)
      use http, only: response_type, request
      class(compiler_explorer), intent(inout) :: this
      type(response_type)                     :: response

      response = request(url=this%api_url//'/api/formats')
      if(.not. response%ok) then
         print *,'Error message : ', response%err_msg
      else
         print *, 'Response Content : ', response%content
      end if
   end subroutine list_formatters
   !===============================================================================

end module forcompile
