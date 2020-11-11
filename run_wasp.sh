#!/bin/bash

set -e
shopt -s nullglob

# Parse command line
if [ $# -lt 2 ] || [ "$1" == "--help" ]; then
    echo "Usage: run_wasp.sh date synthalf"
    exit 0
fi

DATE="$1"
shift
SYNTHALF="$1"
shift

# Set directories
INDIR=/mnt/input-dir
WORKDIR=/work/wasp
OUTDIR=/mnt/output-dir

# Ensure that workdir is clean
if [ -d $WORKDIR ]; then
    rm -rf $WORKDIR
fi
mkdir -p $WORKDIR

# Symlink datasets into workdir
for f in $INDIR/*; do
    ln -s $(readlink -f $f) $WORKDIR/$(basename $f)
done

# Generate INPUT parameter for WASP
INPUT=""
for f in $INDIR/*; do
    INPUT="${INPUT} ./wasp/$(basename $f)/$(basename $f)_MTD_ALL.xml"
done

# Run wasp
mkdir -p $WORKDIR/out
/usr/wasp/bin/WASP --input $INPUT --out $WORKDIR/out --date $DATE --synthalf $SYNTHALF

# Copy outputs from workdir
mkdir -p $OUTDIR
for f in $WORKDIR/out/*; do
    cp -r $f $OUTDIR
done

# Remove all files
rm -rf $WORKDIR
