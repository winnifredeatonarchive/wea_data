#!/bin/bash


echo $1;

for n in *.$1; do vipsthumbnail $n$3 --size x$2 -o %s$4.png -v & done;