set(F_Fortran_FLAGS_TO_CHECK
                              "-Wall"
                              "-fcommon"
                              "-g"
                              "-diag-disable 8291"
                              "-diag-disable 7713"# This statement function has not been used
                              "-O0"
                              "-traceback"
                              "-noalign"
                              "-noauto"
                              "-zero"
                              "-nbs"
                              "-mp1"
   )
if (NOT COMPSUFFIX)
  set( COMPSUFFIX -ifx)
endif()
if (NOT COMPSUFFIXBIN)
  set( COMPSUFFIXBIN -ifx)
endif()