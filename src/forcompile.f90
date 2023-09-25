module forcompile

   implicit none

   private
   public :: compiler_explorer

   !===============================================================================
   !> author: Seyed Ali Ghasemi
   type compilerOptions
      logical :: skipAsm         = .false.
      logical :: executorRequest = .false.
   contains
      procedure :: set_skipAsm
      procedure :: set_executorRequest
   end type compilerOptions
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   type filters
      logical :: binary       = .false.
      logical :: binaryObject = .false.
      logical :: commentOnly  = .false.
      logical :: demangle     = .false.
      logical :: directives   = .false.
      logical :: execute      = .false.
      logical :: intel        = .false.
      logical :: labels       = .false.
      logical :: libraryCode  = .false.
      logical :: trim         = .false.
      logical :: debugCalls   = .false.
   contains
      procedure :: set_binary
      procedure :: set_binaryObject
      procedure :: set_commentOnly
      procedure :: set_demangle
      procedure :: set_directives
      procedure :: set_execute
      procedure :: set_intel
      procedure :: set_labels
      procedure :: set_libraryCode
      procedure :: set_trim
      procedure :: set_debugCalls
   end type filters
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   type tools
      character(len=1024) :: id_args(2)
   end type tools
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   type libraries
      character(len=1024) :: id_version(2)
   end type libraries
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   type options
      character(len=:),     allocatable :: userArguments
      type(compilerOptions)             :: compilerOptions
      type(filters)                     :: filters
      type(tools),          allocatable :: tools(:)
      type(libraries),      allocatable :: libraries(:)
   contains
      procedure :: set_userArguments
      procedure :: set_compilerOptions
      procedure :: set_filters
      procedure :: set_tools
      procedure :: set_libraries
      procedure, private :: deallocate_userArguments
      procedure, private :: deallocate_tools
      procedure, private :: deallocate_libraries
      procedure :: finalize => deallocate_options
   end type options
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   type compiler_explorer
      character(len=19) :: api_url = "https://godbolt.org"
      character(len=:), allocatable :: compiler_id
      character(len=:), allocatable :: source
      character(len=:), allocatable :: lang
      logical                       :: allowStoreCodeDebug
      type(options)                 :: options
   contains
      procedure :: list_languages
      procedure :: list_compilers
      procedure :: list_libraries
      procedure :: list_formatters
      procedure :: set_compiler_id
      procedure :: set_source
      procedure :: set_lang
      procedure :: set_allowStoreCodeDebug
      procedure :: compile
      procedure, private :: deallocate_compiler_id
      procedure, private :: deallocate_source
      procedure, private :: deallocate_lang
      procedure :: finalize => deallocate_comnpiler_explorer
   end type compiler_explorer
   !===============================================================================

contains

   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_filters(this,&
      binary, binaryObject, commentOnly, demangle, directives, execute, intel,&
      labels, libraryCode, trim, debugCalls)
      
      class(options), intent(inout) :: this
      logical, intent(in), optional :: binary
      logical, intent(in), optional :: binaryObject
      logical, intent(in), optional :: commentOnly
      logical, intent(in), optional :: demangle
      logical, intent(in), optional :: directives
      logical, intent(in), optional :: execute
      logical, intent(in), optional :: intel
      logical, intent(in), optional :: labels
      logical, intent(in), optional :: libraryCode
      logical, intent(in), optional :: trim
      logical, intent(in), optional :: debugCalls

      if (present(binary)) call this%filters%set_binary(binary)
      if (present(binaryObject)) call this%filters%set_binaryObject(binaryObject)
      if (present(commentOnly)) call this%filters%set_commentOnly(commentOnly)
      if (present(demangle)) call this%filters%set_demangle(demangle)
      if (present(directives)) call this%filters%set_directives(directives)
      if (present(execute)) call this%filters%set_execute(execute)
      if (present(intel)) call this%filters%set_intel(intel)
      if (present(labels)) call this%filters%set_labels(labels)
      if (present(libraryCode)) call this%filters%set_libraryCode(libraryCode)
      if (present(trim)) call this%filters%set_trim(trim)
      if (present(debugCalls)) call this%filters%set_debugCalls(debugCalls)
   end subroutine set_filters
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_compilerOptions(this, skipAsm, executorRequest)
      class(options), intent(inout) :: this
      logical, intent(in), optional :: skipAsm
      logical, intent(in), optional :: executorRequest

      if (present(skipAsm)) this%compilerOptions%skipAsm = skipAsm
      if (present(executorRequest)) this%compilerOptions%executorRequest = executorRequest
   end subroutine set_compilerOptions
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine deallocate_options(this)
      class(options), intent(inout) :: this
      call this%deallocate_userArguments()
      call this%deallocate_tools()
      call this%deallocate_libraries()
   end subroutine deallocate_options
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine deallocate_comnpiler_explorer(this)
      class(compiler_explorer), intent(inout) :: this
      call this%deallocate_compiler_id()
      call this%deallocate_source()
      call this%deallocate_lang()
      call this%options%finalize()
   end subroutine deallocate_comnpiler_explorer
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine deallocate_userArguments(this)
      class(options), intent(inout) :: this
      if (allocated(this%userArguments)) deallocate(this%userArguments)
   end subroutine deallocate_userArguments
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine deallocate_tools(this)
      class(options), intent(inout) :: this
      if (allocated(this%tools)) deallocate(this%tools)
   end subroutine deallocate_tools
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine deallocate_libraries(this)
      class(options), intent(inout) :: this
      if (allocated(this%libraries)) deallocate(this%libraries)
   end subroutine deallocate_libraries
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine deallocate_compiler_id(this)
      class(compiler_explorer), intent(inout) :: this
      if (allocated(this%compiler_id)) deallocate(this%compiler_id)
   end subroutine deallocate_compiler_id
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine deallocate_source(this)
      class(compiler_explorer), intent(inout) :: this
      if (allocated(this%source)) deallocate(this%source)
   end subroutine deallocate_source
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine deallocate_lang(this)
      class(compiler_explorer), intent(inout) :: this
      if (allocated(this%lang)) deallocate(this%lang)
   end subroutine deallocate_lang
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_source(this, source)
      class(compiler_explorer), intent(inout) :: this
      character(len=*), intent(in)           :: source

      this%source = trim(source)
   end subroutine set_source
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_tools(this, id, args)
      class(options), intent(inout) :: this
      character(len=*), intent(in)  :: id
      character(len=*), intent(in)  :: args
      type(tools), allocatable      :: tmp(:)

      if (.not. allocated(this%tools)) then
         allocate(this%tools(1))
         this%tools(1)%id_args(1) = trim(id)
         this%tools(1)%id_args(2) = trim(args)
      else
         call move_alloc(this%tools, tmp)
         allocate(this%tools(size(tmp)+1))
         this%tools(1:size(tmp)) = tmp
         this%tools(size(tmp)+1)%id_args(1) = trim(id)
         this%tools(size(tmp)+1)%id_args(2) = trim(args)
      end if
   end subroutine set_tools
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_libraries(this, id, version)
      class(options), intent(inout) :: this
      character(len=*), intent(in)  :: id
      character(len=*), intent(in)  :: version
      type(libraries), allocatable      :: tmp(:)

      if (.not. allocated(this%libraries)) then
         allocate(this%libraries(1))
         this%libraries(1)%id_version(1) = trim(id)
         this%libraries(1)%id_version(2) = trim(version)
      else
         call move_alloc(this%libraries, tmp)
         allocate(this%libraries(size(tmp)+1))
         this%libraries(1:size(tmp)) = tmp
         this%libraries(size(tmp)+1)%id_version(1) = trim(id)
         this%libraries(size(tmp)+1)%id_version(2) = trim(version)
      end if
   end subroutine set_libraries
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_binary(this, binary)
      class(filters), intent(inout) :: this
      logical, intent(in)           :: binary

      this%binary = binary
   end subroutine set_binary
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_binaryObject(this, binaryObject)
      class(filters), intent(inout) :: this
      logical, intent(in)           :: binaryObject

      this%binaryObject = binaryObject
   end subroutine set_binaryObject
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_commentOnly(this, commentOnly)
      class(filters), intent(inout) :: this
      logical, intent(in)           :: commentOnly

      this%commentOnly = commentOnly
   end subroutine set_commentOnly
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_demangle(this, demangle)
      class(filters), intent(inout) :: this
      logical, intent(in)           :: demangle

      this%demangle = demangle
   end subroutine set_demangle
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_directives(this, directives)
      class(filters), intent(inout) :: this
      logical, intent(in)           :: directives

      this%directives = directives
   end subroutine set_directives
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_execute(this, execute)
      class(filters), intent(inout) :: this
      logical, intent(in)           :: execute

      this%execute = execute
   end subroutine set_execute
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_intel(this, intel)
      class(filters), intent(inout) :: this
      logical, intent(in)           :: intel

      this%intel = intel
   end subroutine set_intel
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_labels(this, labels)
      class(filters), intent(inout) :: this
      logical, intent(in)           :: labels

      this%labels = labels
   end subroutine set_labels
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_libraryCode(this, libraryCode)
      class(filters), intent(inout) :: this
      logical, intent(in)           :: libraryCode

      this%libraryCode = libraryCode
   end subroutine set_libraryCode
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_trim(this, trim)
      class(filters), intent(inout) :: this
      logical, intent(in)           :: trim

      this%trim = trim
   end subroutine set_trim
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_debugCalls(this, debugCalls)
      class(filters), intent(inout) :: this
      logical, intent(in)           :: debugCalls

      this%debugCalls = debugCalls
   end subroutine set_debugCalls
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_skipAsm(this, skipAsm)
      class(compilerOptions), intent(inout) :: this
      logical, intent(in)                   :: skipAsm

      this%skipAsm = skipAsm
   end subroutine set_skipAsm
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_executorRequest(this, executorRequest)
      class(compilerOptions), intent(inout) :: this
      logical, intent(in)                   :: executorRequest

      this%executorRequest = executorRequest
   end subroutine set_executorRequest
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_userArguments(this, userArguments)
      class(options), intent(inout) :: this
      character(len=*), intent(in)  :: userArguments

      this%userArguments = trim(userArguments)
   end subroutine set_userArguments
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_lang(this, lang)
      class(compiler_explorer), intent(inout) :: this
      character(len=*), intent(in)           :: lang

      this%lang = trim(lang)
   end subroutine set_lang
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_allowStoreCodeDebug(this, allowStoreCodeDebug)
      class(compiler_explorer), intent(inout) :: this
      logical, intent(in)                     :: allowStoreCodeDebug

      this%allowStoreCodeDebug = allowStoreCodeDebug
   end subroutine set_allowStoreCodeDebug
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental pure subroutine set_compiler_id(this, compiler_id)
      class(compiler_explorer), intent(inout) :: this
      character(len=*), intent(in)           :: compiler_id

      this%compiler_id = trim(compiler_id)
   end subroutine set_compiler_id
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental impure subroutine compile(this)
      use http,        only: response_type, request, HTTP_POST, pair_type
      use json_module, only: json_file

      class(compiler_explorer), intent(inout) :: this
      character(len=:),      allocatable   :: jsonstr
      type(pair_type),       allocatable   :: req_header(:)
      type(response_type)                  :: response
      type(json_file)                      :: json
      integer                               :: i
      character(len=10)                     :: i_str

      req_header = [pair_type('Content-Type', 'application/json')]

      call json%initialize()
      call json%add('source', this%source)
      call json%add('options.userArguments', this%options%userArguments)
      call json%add('options.compilerOptions.skipAsm', this%options%compilerOptions%skipAsm)
      call json%add('options.compilerOptions.executorRequest', this%options%compilerOptions%executorRequest)
      call json%add('options.filters.binary', this%options%filters%binary)
      call json%add('options.filters.binaryObject', this%options%filters%binaryObject)
      call json%add('options.filters.commentOnly', this%options%filters%commentOnly)
      call json%add('options.filters.demangle', this%options%filters%demangle)
      call json%add('options.filters.directives', this%options%filters%directives)
      call json%add('options.filters.execute', this%options%filters%execute)
      call json%add('options.filters.intel', this%options%filters%intel)
      call json%add('options.filters.labels', this%options%filters%labels)
      call json%add('options.filters.libraryCode', this%options%filters%libraryCode)
      call json%add('options.filters.trim', this%options%filters%trim)
      call json%add('options.filters.debugCalls', this%options%filters%debugCalls)

      if (allocated(this%options%tools)) then
         do i = 1, size(this%options%tools)
            write(i_str, '(I2)') i
            call json%add('options.tools('//trim(i_str)//').id', trim(this%options%tools(i)%id_args(1)))
            call json%add('options.tools('//trim(i_str)//').args', trim(this%options%tools(i)%id_args(2)))
         end do
      end if
      if (allocated(this%options%libraries)) then
         do i = 1, size(this%options%libraries)
            write(i_str, '(I2)') i
            call json%add('options.libraries('//trim(i_str)//').id', trim(this%options%libraries(i)%id_version(1)))
            call json%add('options.libraries('//trim(i_str)//').version', trim(this%options%libraries(i)%id_version(2)))
         end do
      end if
      call json%add('lang', this%lang)
      call json%add('allowStoreCodeDebug', this%allowStoreCodeDebug)
      call json%print_to_string(jsonstr)
      call json%destroy()

      response = request(url=this%api_url//'/api/compiler/'//trim(this%compiler_id)//'/compile',&
         method=HTTP_POST, data=jsonstr, header=req_header)

      if (response%ok) then
         print*, response%content
      else
         print '(A)', 'Sorry, an error occurred while processing your request.'
         print '(A)', 'Error message:', response%err_msg
      end if
   end subroutine compile
!===============================================================================


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
