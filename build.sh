#!/bin/bash

# emscripten binaries need to be in your $PATH, run "source ./emsdk_env.sh" in the emscripten installation directory to do that

export TMP_OPTI_FLAGS="-ffloat-store -fexcess-precision=style -ffast-math -fno-rounding-math -fno-signaling-nans -fno-math-errno -funsafe-math-optimizations -fassociative-math -freciprocal-math -ffinite-math-only -fno-signed-zeros -fno-trapping-math -frounding-math -fsingle-precision-constant"

emcc -v -O3 $TMP_OPTI_FLAGS -flto --std=c++20 -DNDEBUG --llvm-opts "['Ofast']" fsb-wasm.cpp fsb.cpp -o dist/fsb.js -s MODULARIZE=1 -s 'EXPORT_NAME="createFSBModule"' -s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap"]' -s EXPORTED_FUNCTIONS="['_malloc', '_free']" -s WASM=1

if [ $? == 0 ]; then
  cat dist/fsb.js wrapper/wrapper.js > dist/fsb-wasm.js ;
  rm dist/fsb.js
fi

