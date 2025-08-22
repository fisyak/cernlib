https://cernlib.web.cern.ch/version.html
https://cernlib.web.cern.ch/install/install.html
cmake -S mysourcedir -B mybuilddir -DCMAKE_INSTALL_PREFIX=myinstalldir 
cmake --build mybuilddir 
cmake --install mybuilddir 
cd mybuilddir 
ctest .
--------------------------------------------------------------------------------
git clone git@github.com:fisyak/cernlib.git cernlib
cd cernlib
git co master

[starsub02] ~/sources/cernlib/cernlib 

[starsub02] /gpfs01/star/subsys-tpc/fisyak/STAR/opt/star/al96_x8664_gcc11/lib $ ln -s /usr/lib64/libnsl.so.1 libnsl.so
[starsub02] ~/sources/cernlib/cernlib $ setenv CMAKE_LIBRARY_PATH $LD_LIBRARY_PATH 

cmake -S ~/sources/cernlib/cernlib -B ~/sources/cernlib/build64x -DCMAKE_INSTALL_PREFIX=$XOPTSTAR/cern64
cmake --build  ~/sources/cernlib/build64x -j8
cmake --install ~/sources/cernlib/build64x 
cd ~/sources/cernlib/build64x 
ctest .
