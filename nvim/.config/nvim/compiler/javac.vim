if exists("current_compiler")
  finish
endif

let current_compiler = "javac"

if !filereadable('Makefile') && !filereadable('makefile')
    CompilerSet makeprg=javac\ %
endif


CompilerSet errorformat=%E%f:%l:\ error:\ %m,
		       \%W%f:%l:\ warning:\ %m,
		       \%-Z%p^,
		       \%-C%.%#,
		       \%-G%.%#

