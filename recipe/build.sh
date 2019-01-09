#!/bin/bash
set -ex
set -o pipefail

export CFLAGS="$CFLAGS -std=c99"

autoreconf

./configure --prefix="${PREFIX}" \
    --enable-shared \
    --disable-static \
    --disable-gtk-doc \
    --disable-gtk-doc-html \
    --disable-gtk-doc-pdf \
    --disable-nls \
    --disable-code-coverage \
    --without-libiconv-prefix \
    --without-libintl-prefix \
    --without-gcov \
    2>&1 | tee configure.log

CC="${CC}" make
make check CC="${CC}"
make install CC="${CC}"

# Save some space
rm -rf "${PREFIX}/share/info"
rm -rf "${PREFIX}/share/man"
rm -rf "${PREFIX}/share/gtk-doc"
