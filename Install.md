https://cernlib.web.cern.ch/version.html
https://cernlib.web.cern.ch/install/install.html

cd /gpfs01/star/subsys-tpc/fisyak/sources/cernlib/cernlib 
mkdir ../build64x
setenv CMAKE_INCLUDE_PATH $XOPTSTAR/spack/include
cmake -S . -B ../build64x -DCMAKE_INSTALL_PREFIX=$XOPTSTAR/cern64
cmake --build ..//build64x  -j8
cmake --install ../build64x 
cd ../build64x 
ctest .
