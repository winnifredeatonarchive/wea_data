#!/bin/bash

# This is a fairly simple script that takes a PDf and creates tiles from it

echo "Creating PDF from" $1;

BASE=$(basename ${1%.*})
echo $BASE;

echo "Making dir" ../../tiles/$BASE;

mkdir ../../tiles/$BASE;

#First separate PDF

mkdir ../../tiles/tmp;
mkdir ../../tiles/tmp/$BASE;

echo "Separating PDFs";
pdfseparate $1 ../../tiles/tmp/$BASE/$BASE-%d.pdf;

ITER=0;

echo "Initiating loop";

for n in ../../tiles/tmp/$BASE/*.pdf;
do
    ITER=$((ITER + 1))
    OD="$BASE""_""$ITER";
    echo $n;
    vips dzsave $n[dpi=400] ../../tiles/$BASE/$OD;
done;

echo "Cleaning up";