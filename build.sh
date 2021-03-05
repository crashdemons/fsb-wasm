#!/bin/bash

# emscripten binaries need to be in your $PATH, run "source ./emsdk_env.sh" in the emscripten installation directory to do that

emcc -v -O3 -flto --std=c++20 -DNDEBUG --llvm-opts "['Ofast']" fsb-wasm.cpp fsb.cpp -o dist/fsb.js -s MODULARIZE=1 -s 'EXPORT_NAME="createFSBModule"' -s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap"]' -s EXPORTED_FUNCTIONS="['_malloc', '_free']" -s WASM=1

if [ $? == 0 ]; then
  cat dist/fsb.js wrapper/wrapper.js > dist/fsb-wasm.js ;
  rm dist/fsb.js
fi

