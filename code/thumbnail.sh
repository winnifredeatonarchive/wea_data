#!/bin/bash

for n in *.$1; do vips thumbnail $n$3 %s$4.png $2; done;





