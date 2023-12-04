#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .
#--------------------------------------------------------------------------------
# MetTools - A Collection of Software for Meteorology and Remote Sensing
# Copyright (C) 2016  EUMETSAT
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#--------------------------------------------------------------------------------

set -ex

mkdir build
cd build

cmake ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_COLOR_MAKEFILE=OFF \
  -DCMAKE_INSTALL_PREFIX="$PREFIX" \
  ..

make -j ${CPU_COUNT}
make install
if [[ $OSTYPE == "linux-gnu" ]]; then
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  make test
fi
fi
