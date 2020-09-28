#!/bin/bash
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

export BR2_PACKAGE_LIBICONV=y

if [ "${target_platform}" == "linux-aarch64" ]; then
    ADD_ARG="--build=aarch64-unknown-linux-gnu --host=aarch64-unknown-linux-gnu"
fi

./configure --prefix=${PREFIX} ${ADD_ARG}

make -j ${CPU_COUNT}
make install
