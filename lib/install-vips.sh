#!/bin/bash


# Taken from the ruby vips repo
# https://github.com/libvips/ruby-vips/blob/master/.travis.yml

tar xf lib/vips-8.7.4.tar.gz
cd lib/vips-8.7.4
CXXFLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 ./configure --prefix=$HOME/vips $*
make && make install