#!/bin/bash

## This code creates multiple thumbnails from an input and output image file.

IN=$1
BASE=${IN%.pdf}

BASICPARAMS='+profile 'icc' -background white -alpha remove -alpha off'
MAINOUT=$BASE.png
SMALLOUT=$BASE'_small.png'

echo $IN;
echo $BASE;
echo $BASICPARAMS
echo $MAINOUT
echo $SMALLOUT

convert $IN $MAINOUT