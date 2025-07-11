set(F_Fortran_FLAGS_TO_CHECK
                               "--param=ssp-buffer-size=4"
                               "-fno-backslash"
                               "-ffixed-line-length-72"
                               "-std=legacy"
                               "-fcommon"
                               "-flto"
                               "-fno-strict-aliasing"
                               "-O0"
                               "-g"
#https://www.amd.com/content/dam/amd/en/documents/pdfs/developer/aocc/aocc-v4.0-ga-user-guide.pdf                               
                               "-Mfixed"
                               )
if (NOT COMPSUFFIX)
  set( COMPSUFFIX -flang)
endif()
if (NOT COMPSUFFIXBIN)
  set( COMPSUFFIXBIN -flang)
endif()