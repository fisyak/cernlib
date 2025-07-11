set(F_Fortran_FLAGS_TO_CHECK
                               "--param=ssp-buffer-size=4"
                               "-fno-backslash"
                               "-ffixed-line-length-72"
                               "-std=legacy"
                               "-fcommon"
                               "-fno-automatic"
                               "-fno-second-underscore"
                               "-flto"
                               "-mfpmath=387"
                               "-fno-align-commons"
                               "-fno-aggressive-loop-optimizations"
                               "-finit-local-zero"
                               "-fallow-argument-mismatch"
                               "-fno-range-check"
                               "-fno-bounds-check"
                               "-fbacktrace"
                               "-fno-strict-aliasing"
                               "-Wno-cpp"
                               "-Wno-uninitialized"
                               "-Wall"
                               "-Wno-character-truncation"
                               "-Wno-line-truncation"
                               "-Wno-lto-type-mismatch"
                               "-Wno-integer-division"
                               "-Wno-intrinsic-shadow"
                               "-Wno-argument-mismatch"
                               "-Wno-aggressive-loop-optimizations"
                               "-Wno-unused-label"
                               "-Wno-unused-function"
                               "-Wno-unused-variable"
                               "-Wno-maybe-uninitialized"
                               "-Wno-unused-dummy-argument"
                               "-no-pie"
                               "-O0"
                               "-g"
                               "-fallow-invalid-boz" #needed for patchy4/p4lib/jartpx.F
                               )
#Not clear starting from which version we can rely on the stack protector
if (CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER 4.5)
    list(APPEND F_Fortran_FLAGS_TO_CHECK  "-fstack-protector" )
endif()
if (Fortran_COMPILER_NAME STREQUAL g77)
  SET(CMAKE_C_USE_RESPONSE_FILE_FOR_OBJECTS 0)
  SET(CMAKE_Fortran_USE_RESPONSE_FILE_FOR_OBJECTS 0)
  if (NOT COMPSUFFIX)
    set( COMPSUFFIX -g77)
  endif()
  if (NOT COMPSUFFIXBIN)
    set( COMPSUFFIXBIN -g77)
  endif()
else()
  if (NOT COMPSUFFIX)
    set( COMPSUFFIX -gfortran)
  endif()
  if (NOT COMPSUFFIXBIN)
    set( COMPSUFFIXBIN -gfortran)
  endif()
  list(APPEND F_Fortran_FLAGS_TO_CHECK
                               "-Wno-conversion"
                               "-Wno-implicit-function-declaration"
                               "-Wno-return-type"
   )
endif()