set(C_C_FLAGS_TO_CHECK       "-fcommon"
                               "--param=ssp-buffer-size=4"
                               "-mpreferred-stack-boundary=2"
                               "-fexceptions"
                               "-fasynchronous-unwind-tables"
                               "-fcf-protection"
                               "-fno-strict-aliasing"
                               "-flto"
                               "-trigraphs"
                               "-mfpmath=387"
                               "-grecord-gcc-switches"
                               "-pipe"
                               "-Wall"
                               "-Wno-trigraphs"
                               "-Wno-unused-but-set-variable"
                               "-Wno-unused-function"
                               "-Wno-missing-braces"
                               "-Wno-switch"
                               "-Wno-array-bounds"
                               "-Wno-conversion"
                               "-Wno-uninitialized"
                               "-Wno-implicit-function-declaration"
                               "-Wno-unused-variable"
                               "-Wno-implicit-int"
                               #"-Werror=implicit-function-declaration"
                               #"-Wformat -Werror=format-security"
                               "-no-pie"
                               "-O0"
                               "-g"
                               )
if (CMAKE_C_COMPILER_VERSION VERSION_GREATER 4.0)
     list(APPEND C_C_FLAGS_TO_CHECK
                                     "-fstack-protector-strong"
                                     "-fstack-clash-protection"
                                     )
endif()
if (CMAKE_C_COMPILER_VERSION VERSION_GREATER 4.5)
    list(APPEND C_C_FLAGS_TO_CHECK
                         "-Wno-restrict"
                         "-Wno-unused-result"
                         "-Wno-format-overflow"
                         "-Wno-unused-dummy-argument"
                         "-Wno-maybe-uninitialized"
                         "-Wno-stringop-truncation"
                         "-Wno-incompatible-pointer-types"
                         "-Wno-cpp"
                         "-fstack-protector"
                         )
endif()