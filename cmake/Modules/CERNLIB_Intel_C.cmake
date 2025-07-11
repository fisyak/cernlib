set(C_C_FLAGS_TO_CHECK "-Wno-cpp"
                         "-Wall"
                         "-fcommon"
                         "-diag-disable=117" # non-void function should return a value
                         "-diag-disable=140" # Too many arguments in function call
                         "-diag-disable=165" # Too few arguments in function call
                         "-diag-disable=167" # incompatible parameter
                         "-diag-disable=177"  # labels
                         "-diag-disable=180" # incompatible format
                         "-diag-disable=181"  # format
                         "-diag-disable=266" # implicit declaration
                         "-diag-disable=303" # explicit type is missing
                         "-diag-disable=556"  # value of type "long *" cannot be assigned to an entity of type "int *"
                         "-diag-disable=810" # conversion from char to int
                         "-diag-disable=1224" # _FORTIFY_SOURCE requires compiling with optimization (-O)
                         "-diag-disable=2193" # null argument
                         "-diag-disable=10441" # new compiler
                         "-O0"
                         "-mp1"
                         "-g"
                             )