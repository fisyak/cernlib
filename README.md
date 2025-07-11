# CERNLIB 2025.02

This repository contains all CERNLIB modules with history in a single place.
It is based on the last official release CERNLIB 2006a, with additional patches to support 64bit, mainly developed by Debian.

## Notes

This version is currently being validated. Feedback and bug reports are highly appreciated.

## Changes
Important changes applied in this repository:
- Import of original sources from CVS into git
- Apply bug fixes and 64bit patches from Debian
- Import of (older) LAPACK and BLAS sources
- Import of Monte Carlo libraries
- Added Cmake build system
- Added additional fully typed versions of vzero, uzero, ucopy and vfill
- Added support for aarm64
- Bug fix in paw script for CMake builds
- Improved support for Darwin
- Import select changes requested by Belle
- Add support for xrootd

## Breaking changes
The implementation of mathlib/gen/e/dspin2.F looks wrong and has been corrected in CERNLIB tags 2023.08.X and newer.

## Licensing
Licensing of these sources might be subject to restrictions. This needs further clarification. Please do NOT distribute.

Some information about the licensing situation can be found in the ```contrib``` folder.

## Requirements
CERNLIB building has a couple of external dependencies. Please take a look at ```.gitlab-ci```
in the top folder to get an idea of what is needed.

As an example, to build CERNLIB on CentoOS9 in 32bit first run

```
yum -y install libXfont2-devel.i686 libX11-devel.i686 libXft-devel.i686 motif-devel.i686 libXaw-devel.i686
yum -y install imake gcc gcc-gfortran glibc-devel glibc-devel.i686 libgfortran.i686 libnsl.i686 libnsl2-devel.i686 freetype-devel.i686
```
The list of tested and supported systems as of July 2022 is

| OS                                              | Build system  | Compilers        | Status              | Notes                    |
| :-----------------------------------------------| :-------------|:-----------------|:------------------- |:-------------------------|
| RHEL 4,5,6,7 compatible i686(32bit)             |  imake        | GNU              |  Tested/Tier I      |                          |
| RHEL 4,5,6,7,8,9 compatible x86_64(64bit)       |  imake,cmake  | GNU              |  Tested/Tier I      |                          |
| Ubuntu 18,19,20,21,22 compatible x86_64(64bit)  |  imake        | GNU              |  Tested/Tier I      |                          |
| MacOS12 x86_64(64bit)                           |  imake,cmake  | GNU              |  Tested/Tier II     |Hardcoded flags for imake |
| MacOS14 aarch64(M2)                             |  cmake        | GNU              |  Tested/Tier II     |cmake only, experimental  |
| Solaris11.4/Openindiana  x86_64(64bit)          |  cmake        | GNU              |  Tested/Tier II     |                          |
| RHEL 8 compatible x86_64(64bit)                 |  cmake        | Intel,Nvidia     |  Tested/Tier II     |                          |
| RHEL 7,9 compatible x86_64(64bit)               |  cmake        | Intel,Nvidia     |  Not tested/Tier II |                          |
| RHEL 4,5,6,7,8,9 compatible i686(32bit)         |  cmake        | GNU              |  Not tested/Tier II |                          |
| RHEL 8,9 compatible i686(32bit)                 |  imake        | GNU              |  Not tested/Tier II |                          |
| Ubuntu 18,19,20,21,22  compatible x86_64(64bit) |  cmake        | GNU              |  Not tested/Tier II |                          |
| Ubuntu 18,19,20,21,22  compatible i686(32bit)   |  imake,cmake  | GNU              |  Not tested/Tier II |                          |
| Other Linux i686(32bit),x86_64(64bit)           |  imake,cmake  | GNU              |  Not tested/Tier II |                          |
| Other Linux arm, ppc64, etc                     |  imake,cmake  |                  |  Not tested         |                          |

Where Tier I stands for a full support, while Tier II for a limited support, i.e. testing, bugfixes and and patches will be appreciated.
It is expected that for Tier II some minor problems might occur in the building process.
Note I: on some systems dependencies are not available from the system repositories and should be installed separately.
Note II: some 32-bit builds were performed on the multiach 64-bit systems.

## Special cases
Some distributions like Fedora and Ubuntu ship libXbae, CentOS (and RedHat) don't. The default behaviour of
the build script is to use the external library. For CentOS and RedHat though, dependencies are internally
resolved by adding the switch *CERNLIB_NOLIBXBAE* to config/host.def before configuring the CERNLIB.

## Accessing data over the network

The SHIFT code originally used RFIO to contact the tape mass storage system CASTOR at CERN. Technically, RFIO re-implemented and replaced POSIX file system calls like open, read, write, close etc. However, this protocol is unsecure and has been abandoned already many years ago.

Recent experiments use the ROOT protocol to transfer data. The xrootd toolkit allows to override POSIX file system calls in a very similar manner as RFIO did.
CERNLIB version 2025 and later allow to exploit this, if CERNLIB_SHIFT is enabled. Note that any user code will have to be linked against the xrootd client libraries to be able to link, if this feature is used.

Note: CERNLIB tools do not necessarily support the URL like syntax which the ROOT protocol relies on. To work around, set the environment variable XROOTD_VMP accordingling, e.g.:

```
export XROOTD_VMP=eospublic.cern.ch:/eos/=/eos
```

Note that the ```cernlib``` scripts supports linking against the necessary libraries if the environment variable ```CERNLIB_XROOTD``` is set to "ON". To enable XROOTD support during builds, please set:

```
export CERNLIB_XROOTD=ON
```

For more information, please take a look in the shift folder of this repository.


## 32bit cross compilation
32bit cross compilation mode is activated by adding the switch *CERNLIB_32BITCROSS* to config/host.def

## Standard building with Imake
A standalone build can be done as follows:

First, setup the target folder for the build. This step is optional. The default is /tmp/cern:
```bash
export CERN=/path/to/your/target/folder
```

For a 64bit build run
```bash
./make_cernlib 64bit GNU new $CERNLIB_XROOTD
```

For a 32bit build run
```bash
./make_cernlib 32bit
```
Note that xrootd is only supported in 64bit mode.

## Building with CMake
In addition to the standard dependencies, for this build `cmake` is required.
The best choice on the modern systems is `cmake>=3.18`.
To make the versions `cmake<3.15` work, some modifications to the `CMakeLists.txt` files are needed.
Before the build run in the source tree
```
find -name CMakeLists.txt  sed -i -e 's@list(TRANSFORM@list_TRANSFORM(@g' -e 's@list(JOIN@list_JOIN(@g' {} \;
```
The minimal well-tested version of `cmake` was 3.9.6, which is the highest version of `cmake` that can be compilled on SL4
with the system compiler. Quite likely the versions of `cmake` below 3.6 will not function properly.

The build, install and check with `cmake==3.20` can be done as follows

```
cmake -S mysourcedir -B mybuilddir -DCMAKE_INSTALL_PREFIX=myinstalldir <more cmake options>
cmake --build mybuilddir
cmake --install  mybuilddir
cd mybuilddir
ctest .
```

Unlike the `Imake` build, the `CMake` build allows to build on OSX system and
use Intel, Clang, g77 and NVidia compilers on Linux. All of them, however, should be considered as
"experimental". The top `CMakeLists.txt` has a set of options for each compiler
that will be automatically used when the compiler is detected. Some extra options, including the
compilation flags can be set on top of that using the standard cmake approach
with `-DMY_DESIRED_FLAG=...` in the command line.
So far the following options are supported by top `CMakeLists.txt`
```
CERNLIB_USE_INTERNAL_XBAE          Forces using internal XBAE                                ON
CERNLIB_USE_INTERNAL_LAPACK        Forces using internal LAPACK/BLAS                         ON
CERNLIB_ENABLE_TEST                Enables building of tests                                 ON
CERNLIB_ENABLE_MEMORYTEST          Adds memory check tests with valgind                      OFF
CERNLIB_FORCE_FLAGS                Use compilation flags from the command line only          OFF
CERNLIB_POSITION_INDEPENDENT_CODE  Position independent code for static libraries            OFF
CERNLIB_BUILD_SHARED               Build shared libraries                                    OFF
CERNLIB_SHIFT                      Build with dummy shift support                            OFF
CERNLIB_FORCE_32                   Force build of 32-bit libraries on 64-bit multiach host   OFF
CERNLIB_GFLUKA                     Build with GFluka support (non-free)                      ON
CERNLIB_QDEBUG                     Enable debug statements (dev only)                        OFF
CERNLIB_QPRINT                     Enable specific debug statements (dev only)               OFF
CERNLIB_QDEVZE                     Enable specific debug statements (Zebra dev)              OFF
CERNLIB_NO_SUFFIX                  Do not append the compiler suffix to the executables      ON
```

When needed, the compilation options can be adjusted directly in `CMakeLists.txt`.
Please note:
 - all compilers apply "-O0" and "-g" in the `CMakeLists.txt`.
 - it is likely that shared libraries might not always work

## CI (for advanced users/developers)
The CERN gitlab continuous integration system (CI) is configured to run many different build configurations.
The build script `CI/build.sh` either wraps around the `make_cernlib` or uses CMake for the builds.
As arguments it takes
 - the build system name, to either use `imake` or `cmake`
 - the type of build -- `tarball`, `tarball32bit` or `rpm`
 - the toolchain to use, e.g. `GNU`, `INTEL`, `GNU4`, see details in the build script
 - `bear` or `bear3` enables use of `bear` utility version 2/3 to create a compilation database

Please note:
- Not all combinations of options are meaningful.
- While some builds are performed using the stock images of Fedora/Ubuntu/CentOS,
for the older systems the specially prepared containers are used.
- The 32-bit builds are performed in some cases on the 64-bit multiarch systems and
 therefore all the 32bit libraries are needed and the compilers should be supplied with
 the appropriate flags (e.g. "-m32" in case of gfortran)

## Changes of CMake build system (for advanced users/developers)
The wast majority of CMake code is generated automatically from the Imake files via the
the script `CI/imake2cmake.py`. The automatically generated CMake files should not be edited,
the script `CI/imake2cmake.py` should be edited if some changes are needed.

## Automatically created binaries
The CI creates CERNLIB binaries automatically. To download them, go to the CI/CD and choose "Pipelines".
On the very right you see a pull down menu which allows to download the created artifacts.

## Extensions
Adding the flag ```CERNLIB_2022``` at compile time adds explicitly typed version of some frequently used functions, namely:

* vzeroi, vzerol, vzeror and vzerod: integer, logical, real and double precision version of vzero
* ucopyi, ucopyl, ucopyr and ucopyd: integer, logical, real and double precision version of ucopy
* vfilli, vfilll, vfillr and vfilld:  integer, logical, real and double precision version of vfill
* uzeroi, uzeror and uzerod:  integer, real and double precision version of uzero

Note that these are not available in the default CI builds for the time being.
