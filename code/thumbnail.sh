#!/bin/bash

for n in *.$1; do vipsthumbnail $n$3 -o %s$4.png --size x$2; done;





