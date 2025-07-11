set(F_Fortran_FLAGS_TO_CHECK
                               "-g"
                               "-qnosave"
                               "-qextname"
                               "-qfixed=72"
                               "-qsuppress=1500-030"
                               "-qsuppress=1520-065"
                               "-qsuppress=1501-510"
                               "-qsuppress=1514-022"
)
if (NOT COMPSUFFIX)
  set( COMPSUFFIX -xl)
endif()
if (NOT COMPSUFFIXBIN)
  set( COMPSUFFIXBIN -xl)
endif()