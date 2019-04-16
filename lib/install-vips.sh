#!/bin/bash



# Taken from the ruby vips repo
# https://github.com/libvips/ruby-vips/blob/master/.travis.yml

set -e

# do we already have the correct vips built? early exit if yes
# we could check the configure params as well I guess
if [ -d "$HOME/vips/bin" ]; then
		echo "Using cached directory"
		exit 0
fi

rm -rf $HOME/vips
wget $vips_site/v$version/vips-$version.tar.gz
tar xf vips-$version.tar.gz
cd vips-$version
CXXFLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 ./configure --prefix=$HOME/vips $*
make && make install