set(F_Fortran_FLAGS_TO_CHECK
                               "-fcommon"
                               "-traceback"
                               "-Mnobounds"
                               "-Mnostandard"
                               "-Mnobackslash"
                               "-Mpreprocess"
                               "-Mnosave"
                               "-Mnofree"
                               "-Wno-cpp"
                               "-O0"
                               "-g"
   )
if (NOT COMPSUFFIX)
    set( COMPSUFFIX -nvfortran)
endif()
if (NOT COMPSUFFIXBIN)
  set( COMPSUFFIXBIN -nvfortran)
endif()