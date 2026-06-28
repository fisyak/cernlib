#!/bin/bash

TOP=$(pwd); export TOP
set -x
BUILDSYSTEM="$1"
#[imake = Imake  cmake = CMake]
TARGET="$2"
#[tarball, rpm = build RPMs, tarball32bit = pass -m32 to tarball]
TOOLCHAIN="$3"
#[GNU,INTEL,NVIDIA,CLANG]
BEAROPTION="$4"
#Build with XROOTD support
CERNLIB_XROOTD="$5"
#[anything, bear = use bear, bear3 = use bear version 3 ]
#CERNLIB version
CL_VERSION=2026.06

if [ "$TARGET" != "rpm" ] && [ "$TARGET" != "brew" ]; then
echo "$TMP"
unset TMP
mkdir -p /tmp
CHUARCH=64bit
if [ "$TARGET" = "tarball32bit" ]; then
CHUARCH=32bit
fi
if  [ "$BUILDSYSTEM" = "imake" ]; then
  CERN=$(pwd)"/tmp/cern"; export CERN
  if [ "$BEAROPTION" = "bear3" ]; then
    bear --output imakeGNU.json -- sh make_cernlib "$CHUARCH" "$TOOLCHAIN" "$CERNLIB_XROOTD"
    exit $?
  fi
  if [ "$BEAROPTION" = "bear" ]; then
    bear --cdb imakeGNU.json sh make_cernlib "$CHUARCH" "$TOOLCHAIN" "$CERNLIB_XROOTD"
    exit $?
  fi
  ./make_cernlib "$CHUARCH" "$TOOLCHAIN" "$CL_VERSION" "$CERNLIB_XROOTD"
  exit "$?"
fi
fi

cd "${TOP}" || exit
unset TMP

mkdir -p "TEMP/${CL_VERSION}/src"

sed -e 's/__CL_VERSION__/'"${CL_VERSION}"'/g' CMakeLists.txt >   TEMP/"${CL_VERSION}"/src/CMakeLists.txt
cp -r cmake      "TEMP/${CL_VERSION}/src"
cp -r lapack     "TEMP/${CL_VERSION}/src"
cp -r cfortran   "TEMP/${CL_VERSION}/src"
cp -r geant321   "TEMP/${CL_VERSION}/src"
cp -r phtools    "TEMP/${CL_VERSION}/src"
cp -r scripts    "TEMP/${CL_VERSION}/src"
cp -r config     "TEMP/${CL_VERSION}/src"
cp -r mclibs     "TEMP/${CL_VERSION}/src"
cp -r packlib    "TEMP/${CL_VERSION}/src"
cp -r kernlib    "TEMP/${CL_VERSION}/src"
cp -r pawlib     "TEMP/${CL_VERSION}/src"
cp -r mathlib    "TEMP/${CL_VERSION}/src"
cp -r graflib    "TEMP/${CL_VERSION}/src"
cp -r paw_motif  "TEMP/${CL_VERSION}/src"
cp -r code_motif "TEMP/${CL_VERSION}/src"
cp -r contrib    "TEMP/${CL_VERSION}/src"
cp  Imakefile    "TEMP/${CL_VERSION}/src"
cp -r include    "TEMP/${CL_VERSION}/src"
cp -r patchy5    "TEMP/${CL_VERSION}/src"
cp -r patchy4    "TEMP/${CL_VERSION}/src"

declare -a extra_args

if [ "$TARGET" != "rpm" ] && [ "$TARGET" != "brew" ]; then
  if [ "$BUILDSYSTEM" = "cmake" ]; then
    sed -e  's/__CL_VERSION__/'"${CL_VERSION}"'/g' CMakeLists.txt > TEMP/"${CL_VERSION}"/src/CMakeLists.txt
    cd "TEMP/${CL_VERSION}/src" || exit
    export PYTHON=python
    if [ -f /usr/bin/python3 ]; then
      export PYTHON=python3
    fi
    if [[ "$TOOLCHAIN" = *CLANG ]]; then
     export TOOLCHAIN=CLANG
     export CC=clang
     export CXX=clang++
     export FC=gfortran
    fi
    if [ "$TOOLCHAIN" = "GNU" ]; then
     export TOOLCHAIN=GNU
     export CC=gcc
     export FC=gfortran
    fi
    if [[ "$TOOLCHAIN" = GNU-* ]]; then
     N=$(echo "$TOOLCHAIN" | cut -f 2 -d-)
     export TOOLCHAIN="GNU-$N"
     export CC="gcc-$N"
     export FC="gfortran-$N"
    fi
    if [ "$TOOLCHAIN" = "GNU3" ]; then
     export TOOLCHAIN=GNU3
     export CC=gcc
     export FC=g77
     extra_args=( "${extra_args[@]}" -DCERNLIB_USE_INTERNAL_XBAE=ON )
    fi
    if [ "$TOOLCHAIN" = "GNU4" ]; then
     export TOOLCHAIN=GNU4
     export CC=gcc4
     export FC=gfortran
     extra_args=( "${extra_args[@]}" -DCERNLIB_USE_INTERNAL_LAPACK=ON -DCERNLIB_USE_INTERNAL_XBAE=ON )
    fi
    if [ "$TOOLCHAIN" = "GNU14" ]; then
     export TOOLCHAIN=GNU14
     export CC=gcc
     export FC=gfortran
     extra_args=( "${extra_args[@]}" -DCERNLIB_USE_INTERNAL_XBAE=ON )
    fi
    if [[ $TOOLCHAIN = *NVIDIA ]]; then
     set +x
     nvidiaversion=$(ls -1r /opt/nvidia/hpc_sdk/modulefiles/nvhpc/ | grep 2 | head -n 1)
     module  load "/opt/nvidia/hpc_sdk/modulefiles/nvhpc/$nvidiaversion"
     set -x
     export TOOLCHAIN=NVIDIA
     export CC=nvc
     export FC=nvfortran
    fi
    if [[ "$TOOLCHAIN" = *INTEL ]]; then
     set +x
     intelversion=$(ls -1r /opt/intel/oneapi/compiler/ | grep 20 | head -n 1)
     if [ -e "/opt/intel/oneapi/compiler/$intelversion/env/vars.sh" ]; then
         source "/opt/intel/oneapi/compiler/$intelversion/env/vars.sh"
     else
         echo "WARNING: Cannot find /opt/intel/oneapi/compiler/$intelversion/env/vars.sh"
     fi
     set -x
     export TOOLCHAIN=INTEL
     export CC=icc
     export FC=ifort
    fi
    export CMAKE=cmake
    if [ -f /usr/bin/cmake3 ]; then
      export CMAKE=cmake3
    fi
    CMAKE_VERSION=$($CMAKE --version | head -n 1  | grep -oh "[0123456789\.].*" | sed 's/\./\*10000\+/1' | sed 's/\./\*100\+/1' | sed 's/\./\*1\+/1' | sed 's/\./\*0\+/1' | bc -l )
    SED="sed"
    if [ "$(uname)" = "Darwin" ]; then
        if [ -e /usr/local/Cellar/openmotif ]; then
            openmotifversion=$(ls -1r /usr/local/Cellar/openmotif/ | head -n 1)
            extra_args=( "${extra_args[@]}" -DMOTIF_INCLUDE_DIR=/usr/local/Cellar/openmotif/"$openmotifversion"/include/  -DMOTIF_LIBRARIES=/usr/local/Cellar/openmotif/"$openmotifversion"/lib/libXm.dylib )
        else
            openmotifversion=$(ls -1r /opt/homebrew/Cellar/openmotif/ | head -n 1)
            extra_args=( "${extra_args[@]}" -DMOTIF_INCLUDE_DIR=/opt/homebrew/Cellar/openmotif/"$openmotifversion"/include/  -DMOTIF_LIBRARIES=/opt/homebrew/Cellar/openmotif/"$openmotifversion"/lib/libXm.dylib )
        fi
      SED="gsed"
    fi
    if [ "$(uname)" = "SunOS" ]; then
      SED="gsed"
      extra_args=( "${extra_args[@]}" -DCERNLIB_USE_INTERNAL_XBAE=ON  -DCERNLIB_USE_INTERNAL_LAPACK=ON )
    fi
    BEAR=""
    if [ "$BEAROPTION" = "bear" ]; then
      BEAR="bear --cdb ${TOP}/cmake$TOOLCHAIN.json "
    fi
    if [ "$BEAROPTION" = "bear3" ]; then
      BEAR="bear --output ${TOP}/cmake$TOOLCHAIN.json --"
    fi
    if [ "$TARGET" = "tarball32bit" ]; then
      extra_args=( "${extra_args[@]}" -DCERNLIB_FORCE_32=ON )
    fi

    if [ "$CMAKE_VERSION" -lt 31500 ]; then
      find ./ -name CMakeLists.txt -exec "$SED" -i -e 's@list(TRANSFORM@list_TRANSFORM(@g' -e 's@list(JOIN@list_JOIN(@g' {} \;
    fi
    mkdir -p "BUILD$TOOLCHAIN"
    cd "BUILD$TOOLCHAIN" || exit
    if [ "$TARGET" != "rpm" ] && [ "$TARGET" != "brew" ]; then
        "$CMAKE" ../ "${extra_args[@]}"  -DCERNLIB_NO_SUFFIX=1 -DCERNLIB_2022=yes -DCERNLIB_POSITION_INDEPENDENT_CODE=ON -DCMAKE_C_COMPILER="${CC}" -DCERNLIB_BUILD_SHARED=OFF -DCMAKE_Fortran_COMPILER="${FC}" -DCERNLIB_ENABLE_TEST=ON -DCMAKE_INSTALL_PREFIX=/2025.11 -DCERNLIB_XROOTD="${CERNLIB_XROOTD}"
        if [ "$BEAR" ]; then
            "$BEAR" make -j 20 || exit "$?"
        else
            make -j 20 || exit "$?"
        fi
        ctest . --force-new-ctest-process --output-on-failure --timeout 60 -E 'testgexam2|testgexam4' || ctest . --force-new-ctest-process --output-on-failure --rerun-failed --timeout 60 -j 1 || ctest . --force-new-ctest-process --output-on-failure --rerun-failed --timeout 60 -j 1 -E 'testzebfz2|testkernnumtest|testgent|testerexam1|testerexam2|testzexam|testgexam2|testgexam4'  -j 1
        mkdir -p "${TOP}/cern"
        $CMAKE --install .
        make DESTDIR="${TOP}/cern install"
        exit "$?"
    else
      "$CMAKE"   ../ "${extra_args[@]}" -DCERNLIB_NO_SUFFIX=1 -DCERNLIB_2022=yes -DCERNLIB_POSITION_INDEPENDENT_CODE=ON -DCMAKE_C_COMPILER="${CC}" -DCERNLIB_BUILD_SHARED=OFF -DCMAKE_Fortran_COMPILER="${FC}" -DCERNLIB_ENABLE_TEST=ON  -DCMAKE_INSTALL_PREFIX="${TOP}/INSTALLCMAKE" -DCMAKE_INSTALL_LIBDIR="${TOP}"/INSTALLCMAKE"$TOOLCHAIN"/lib64/cernlib/"$CL_VERSION"/lib -DCMAKE_INSTALL_INCLUDEDIR="${TOP}"/INSTALLCMAKE"$TOOLCHAIN"/include/cernlib/"$CL_VERSION" -DCERNLIB_XROOTD="${CERNLIB_XROOTD}"
      "$BEAR" make -j 20 || exit $?
      "$CMAKE" --install . || exit $?
      ctest . --force-new-ctest-process --output-on-failure --timeout 60 -E 'testgexam2|testgexam4' || ctest . --force-new-ctest-process --output-on-failure --rerun-failed --timeout 60 -j 1 || ctest . --force-new-ctest-process --output-on-failure --rerun-failed --timeout 60 -j 1 -E 'testzebfz2|testkernnumtest|testgent|testerexam1|testerexam2|testzexam|testgexam2|testgexam4'  -j 1
      exit "$?"
    fi
  fi # build system is cmake
fi

if [ "$TARGET" = "brew" ] &&  [ "$(uname)" = "Darwin" ]; then
  cd "${TOP}/TEMP" || exit
  gsed -i 's/CMAKE_VERBOSE_MAKEFILE\ ON/CMAKE_VERBOSE_MAKEFILE\ OFF/g' "${CL_VERSION}"/src/CMakeLists.txt
  rm -rf "${CL_VERSION}"/CI/cernlib.rb
  tar -zcf   --sort=name --no-acls  --no-xattrs   "${CL_VERSION}"_src.tar.gz "${CL_VERSION}"
  SHA256SUM=$(sha256sum ${CL_VERSION}_src.tar.gz | cut -f 1 -d' ')
  cd "${TOP}" || exit
  mkdir -p /tmp
  export HOME="${TOP}"
  cd "${TOP}"/TEMP || exit
  mkdir -p Formula
  cp "${TOP}"/CI/cernlib.rb Formula
  gsed -i   '5i\ \ url \"file://'"${TOP}"'/TEMP/'"${CL_VERSION}"'_src.tar.gz\"' Formula/cernlib.rb
  gsed -i   '6i\ \ sha256\ \"'"$SHA256SUM"'\"' Formula/cernlib.rb
  brew install --build-bottle Formula/cernlib.rb
  exit $?
fi


if [ "$TARGET" = "rpm" ] &&  [ "$(uname)" = "Linux" ]; then
  cd "${TOP}"/TEMP || exit
  tar -zcf  "${CL_VERSION}"_src.tar.gz "${CL_VERSION}"
  cd "${TOP}" || exit
  mkdir -p /tmp
  export HOME="${TOP}"
  if [ "$BUILDSYSTEM" = "cmake" ]; then
    mkdir -p "${TOP}"/rpmbuildcmake/{SOURCES,SPECS,RPMS,SRPMS,BUILD}
    mv TEMP/"${CL_VERSION}"_src.tar.gz   rpmbuildcmake/SOURCES/"${CL_VERSION}"_src-free.tar.gz
    sed 's/__CL_VERSION__/'${CL_VERSION}'/g' CI/cernlib.spec.cmake >  "${TOP}"/cernlib.spec.cmake
    RHL=$(grep -ohw '[0123456789.]*' /etc/redhat-release | cut -f 1 -d.)
    if [ "$RHL" ]; then
      if (( RHL < 6 )); then
        echo '%rhel '"$RHL" > "${TOP}"/.rpmmacros
      fi
    fi
    echo '%_topdir '"${TOP}"'/rpmbuildcmake' >> "${TOP}"/.rpmmacros
    if [ "$BEAROPTION" = "bear" ]; then
      rpmbuild -bs        "${TOP}"/CI/cernlib.spec.cmake.debug
      rpmbuild --rebuild  "${TOP}"/rpmbuildcmake/SRPMS/cernlib-*"${CL_VERSION}"-*
    else
      mkdir -p "${TOP}"/rpmbuildcmake/BUILD
      rpmbuild -bs        "${TOP}"/cernlib.spec.cmake
      rpmbuild --rebuild  "${TOP}"/rpmbuildcmake/SRPMS/cernlib-*"${CL_VERSION}"-*
    fi
    exit "$?"
  fi
  if [ "$BUILDSYSTEM" = "imake" ]; then
    mkdir -p "${TOP}"/rpmbuild/{SOURCES,SPECS,RPMS,SRPMS,BUILD}
    RHL=$(grep -ohw '[0123456789.]*'  /etc/redhat-release | cut -f 1 -d.)
    if [ "$RHL" ]; then
    if (( RHL < 6 )); then
      echo '%rhel '"$RHL" > "${TOP}"/.rpmmacros
    fi
    fi
    echo '%_topdir '"${TOP}"'/rpmbuild' >> "${TOP}"/.rpmmacros
    mv TEMP/"${CL_VERSION}"_src.tar.gz   rpmbuild/SOURCES/"${CL_VERSION}"_src-free.tar.gz
    if [ "$BEAROPTION" = "bear" ]; then
      rpmbuild -bs       "${TOP}"/CI/cernlib.spec.debug
      rpmbuild --rebuild "${TOP}"/rpmbuild/SRPMS/cernlib-"${CL_VERSION}"-*
    else
      rpmbuild -bs       "${TOP}"/CI/cernlib.spec
      rpmbuild --rebuild "${TOP}"/rpmbuild/SRPMS/cernlib-"${CL_VERSION}"-*
    fi
    exit "$?"
  fi
fi
echo "You set wrong combination of arguments for this system"
exit 1
