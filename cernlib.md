# The cernlib installation procedure:
if (! -d ${XOPTSTAR}/cern) mkdir ${XOPTSTAR}/cern
if (! -d build.${STAR_HOST_SYS}) mkdir build.${STAR_HOST_SYS}
setenv CMAKE_LIBRARY_PATH $LD_LIBRARY_PATH 
cmake -S cernlib -B build.${STAR_HOST_SYS} -DCMAKE_INSTALL_PREFIX=${XOPTSTAR}/cern
cmake --build build.${STAR_HOST_SYS}  -j8
cmake --install build.${STAR_HOST_SYS} 
cd build.${STAR_HOST_SYS} 
ctest .
echo $STAR_HOST_SYS | grep x8664
if ($?) exit
cd ${XOPTSTAR}; ln -s cern cern64; cd cern; ln -s lib64 lib; ln -s . pro
