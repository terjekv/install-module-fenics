#!/bin/bash

PYTHON_VERSION="${1:-2}"

case $PYTHON_VERSION in
  [2-3])
  ;;
  *)
  echo "Unknown python version ('$PYTHON_VERSION') requested, exiting."
  exit 1;
  ;;
esac


PACKAGE_BASE="/opt/uio/modules/packages"
MODULE_FILE_PATH="/opt/uio/modules/software"
MODULE_CATEGORY="FEniCS"
ANACONDA_RELEASE=$(wget -q -O- https://docs.continuum.io/anaconda/changelog | egrep 'h2.*:' | awk '{print $2}' | cut -f1 -d: | head -1 )
FENICS_RELEASE=$( git ls-remote --tags https://bitbucket.org/fenics-project/dolfin.git | head -1 | cut -f3 -d/ )

# mpi4py breaks this install, do not add.
EXTRA_PACKAGES="scipy"

# Anaconda2-4.3.1-Linux-x86_64.sh
ANACONDA_FLAVOR="Anaconda$PYTHON_VERSION-$ANACONDA_RELEASE"
ANACONDA_INSTALLER="$ANACONDA_FLAVOR-Linux-x86_64.sh"

MODULE_NAME="$FENICS_RELEASE-$ANACONDA_FLAVOR"
PACKAGE_ROOT=$PACKAGE_BASE/$MODULE_CATEGORY/$MODULE_NAME

echo cp skel.tcl /tmp;

echo cd /tmp
echo wget https://repo.continuum.io/archive/$ANACONDA_INSTALLER

echo bash ./$ANACONDA_INSTALLER -b -p $PACKAGE_ROOT
echo $PACKAGE_ROOT/bin/conda create --yes --name fenicsproject --channel conda-forge fenics 

# /opt/uio/modules/packages/FEniCS/2017.01-anaconda2-4.3.1/bin/conda create -n fenicsproject -c conda-forge fenics

for p in $EXTRA_PACKAGES; do
  echo $PACKAGE_ROOT/bin/conda install --yes --name fenicsproject $p
done

echo cp skel.tcl $MODULE_FILE_PATH/$MODULE_CATEGORY/$MODULE_NAME

cd -