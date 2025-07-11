set(F_Fortran_FLAGS_TO_CHECK
                              "-Wall"
                              "-fcommon"
                              "-g"
                              "-diag-disable6178" # return value is not defined
#                              "-diag-disable7615"
                              "-diag-disable7713" # Statement function has not been used
                              "-diag-disable7784" # Symbol in BLOCK DATA program unit is not in a COMMON block.
                              "-diag-disable8291" # Recommended relationship between field width
                              "-diag-disable8577" # The scale factor (k) ..
                              "-diag-disable=10448"
                              "-O0"
                              "-traceback"
                              "-noalign"
                              "-noauto"
                              "-zero"
                              "-nbs"
                              "-mp1"
   )
if (NOT COMPSUFFIX)
  set( COMPSUFFIX -ifort)
endif()
if (NOT COMPSUFFIXBIN)
  set( COMPSUFFIXBIN -ifort)
endif()