[![GitHub](https://img.shields.io/badge/GitHub-ForCompile-blue.svg?style=social&logo=github)](https://github.com/gha3mi/forcompile)
[![Version](https://img.shields.io/github/v/tag/gha3mi/forcompile?color=blue&logo=github&style=flat)](https://github.com/gha3mi/forcompile/releases)
[![Documentation](https://img.shields.io/badge/ford-Documentation%20-blueviolet.svg)](https://gha3mi.github.io/forcompile/)
[![License](https://img.shields.io/github/license/gha3mi/forcompile?color=green)](https://github.com/gha3mi/forcompile/blob/main/LICENSE)
[![Build](https://github.com/gha3mi/forcompile/actions/workflows/ci.yml/badge.svg)](https://github.com/gha3mi/forcompile/actions/workflows/ci.yml)

<img alt="ForCompile" src="https://github.com/gha3mi/forcompile/raw/main/media/logo.png" width="750">

**ForCompile**: A Fortran library to access the Compiler Explorer API.

## How to use

**Prerequisites:**

On Ubuntu, you need to install the curl development headers. Use the following command:

```shell
sudo apt install -y libcurl4-openssl-dev
```

**Clone the repository:**

You can clone the ForCompile repository from GitHub using the following command:

```shell
git clone https://github.com/gha3mi/forcompile.git
```

```shell
cd forcompile
```

## list of languages

```fortran
program test_1

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%list_compilers()

end program test_1
```

## list of compilers

```fortran
program test_2

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%list_languages()

end program test_2
```

## list of compilers with matching language

```fortran
program test_3

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%list_compilers(language_id='fortran')

end program test_3
```

## list of libraries

```fortran
program test_4

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%list_libraries()

end program test_4
```

## list of libraries with matching language

```fortran
program test_5

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%list_libraries(language_id='fortran')

end program test_5
```

## list of code formatters

```fortran
program test_6

   use forcompile, only: compiler_explorer
   implicit none
   type(compiler_explorer) :: ce

   call ce%list_formatters()

end program test_6
```

## perform a compilation

```fortran
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
```

## fpm dependency

If you want to use `ForCompile` as a dependency in your own fpm project,
you can easily include it by adding the following line to your `fpm.toml` file:

```toml
[dependencies]
forcompile = {git="https://github.com/gha3mi/forcompile.git"}
```

## API documentation

The most up-to-date API documentation for the master branch is available
[here](https://gha3mi.github.io/forcompile/).
To generate the API documentation for `ForCompile` using
[ford](https://github.com/Fortran-FOSS-Programmers/ford) run the following
command:

```shell
ford ford.yml
```

## Contributing

Contributions to `ForCompile` are welcome!
If you find any issues or would like to suggest improvements, please open an issue.
