#!/bin/bash -x
set

br=$1 
wo=$2
ur=$3
dr=$4

git checkout-index --prefix=$wo/OUT/ -a
cd $wo

rm OUT/geant321/block/fdevap.F
rm OUT/geant321/block/fdnopt.F
rm OUT/geant321/block/fdpree.F
rm OUT/geant321/block/flkdt1.F
rm OUT/geant321/block/flkdt2.F
rm OUT/geant321/block/flkdt3.F
rm OUT/geant321/block/flkdt4.F
rm OUT/geant321/block/flkdt5.F
rm OUT/geant321/block/flkdt6.F
rm OUT/geant321/block/flkdt7.F
rm OUT/geant321/block/Imakefile
rm OUT/geant321/data/flukaaf.dat
rm OUT/geant321/fiface -rf
rm OUT/geant321/fluka -rf
rm OUT/geant321/geant321/aadat.inc
rm OUT/geant321/geant321/auxpar.inc
rm OUT/geant321/geant321/balanc.inc
rm OUT/geant321/geant321/bamjcm.inc
rm OUT/geant321/geant321/cmsres.inc
rm OUT/geant321/geant321/comcon.inc
rm OUT/geant321/geant321/corinc.inc
rm OUT/geant321/geant321/dblprc.inc
rm OUT/geant321/geant321/decayc2.inc
rm OUT/geant321/geant321/decayc.inc
rm OUT/geant321/geant321/depnuc.inc
rm OUT/geant321/geant321/dimpar.inc
rm OUT/geant321/geant321/eva0.inc
rm OUT/geant321/geant321/eva1.inc
rm OUT/geant321/geant321/fheavy.inc
rm OUT/geant321/geant321/finlsp2.inc
rm OUT/geant321/geant321/finlsp3.inc
rm OUT/geant321/geant321/finlsp.inc
rm OUT/geant321/geant321/finpar2.inc
rm OUT/geant321/geant321/finpar.inc
rm OUT/geant321/geant321/finuc2.inc
rm OUT/geant321/geant321/finuc.inc
rm OUT/geant321/geant321/finuct.inc
rm OUT/geant321/geant321/hadflg.inc
rm OUT/geant321/geant321/hadpar.inc
rm OUT/geant321/geant321/higfis.inc
rm OUT/geant321/geant321/inpdat2.inc
rm OUT/geant321/geant321/inpdat.inc
rm OUT/geant321/geant321/inpflg.inc
rm OUT/geant321/geant321/iounit.inc
rm OUT/geant321/geant321/isotop.inc
rm OUT/geant321/geant321/labcos.inc
rm OUT/geant321/geant321/mapa.inc
rm OUT/geant321/geant321/metlsp.inc
rm OUT/geant321/geant321/nucdat.inc
rm OUT/geant321/geant321/nucgeo.inc
rm OUT/geant321/geant321/nuclev.inc
rm OUT/geant321/geant321/nucpar.inc
rm OUT/geant321/geant321/nucstf.inc
rm OUT/geant321/geant321/paprop.inc
rm OUT/geant321/geant321/parevt.inc
rm OUT/geant321/geant321/parnuc.inc
rm OUT/geant321/geant321/part2.inc
rm OUT/geant321/geant321/part3.inc
rm OUT/geant321/geant321/part.inc
rm OUT/geant321/geant321/qquark.inc
rm OUT/geant321/geant321/reac.inc
rm OUT/geant321/geant321/redver.inc
rm OUT/geant321/geant321/resnuc.inc
rm OUT/geant321/geant321/split.inc
rm OUT/geant321/geant321/xsepar.inc
#cernlib-2023.10.31.0/geant321/gkine/dummy.c
rm OUT/geant321/miface/gfmdis.F
rm OUT/geant321/miface/gfmfin.F
rm OUT/geant321/peanut -rf 

git clone $ur
cd  $dr 
git branch $br
git checkout $br

existed_in_origin=$( git ls-remote --heads origin $br)

if [[ -z "$existed_in_origin" ]]; then
 echo "Not in origin"
else
 git branch --set-upstream-to=origin/$br $br
 git pull
fi


git rm -rf ./* ./.github ./.gitlab*
mv ../OUT/* ./
mv ../OUT/.gitlab* ./
mv ../OUT/.github* ./
git add ./* ./.github* ./.gitlab*
sed  -i '1,/free:/!d'  .gitlab-ci.yml
sed  -i 's/free://g'  .gitlab-ci.yml

sed -i 's@x38@x37@g' make_cernlib
sed -i 's@_src.tar.gz@_src-free.tar.gz@g' CI/build.sh
sed -i 's@_src.tar.gz@_src-free.tar.gz@g' CI/cernlib.spec
sed -i 's@_src.tar.gz@_src-free.tar.gz@g' CI/cernlib.spec.cmake
sed -i 's@gexam4@@g' geant321/examples/Imakefile
sed -i '/^SubdirDataFile.*/d' geant321/Imakefile
sed -i '/^InstallNonExecFileTarget.*/d' geant321/Imakefile
sed -i 's@peanut@@g' geant321/Imakefile
sed -i 's@block@@g' geant321/Imakefile
sed -i 's@fiface@@g' geant321/Imakefile
sed -i 's@fluka@@g' geant321/Imakefile
sed -i 's@GFluka\." ON@GFluka\." OFF@g' CMakeLists.txt
sed -i '3i SRCS_C= dummy.c' geant321/gkine/Imakefile 

git config --global user.email "you@example.com"
export GIT_EDITOR=true
git commit -m "Sync with upstream" ./

if [[ -z "$existed_in_origin" ]]; then
  git push -u origin $br
else
  git push
fi