#!/bin/bash
rm -rf dist/ai
rm -rf dist/baseset
rm -rf dist/game
rm -rf dist/lang
rm -rf dist/openttd

cp -r ../../build/ai dist/
cp -r ../../build/baseset dist/
cp -r ../../build/game dist/
cp -r ../../build/lang dist/
cp -r ../../build/openttd dist/

ares-package dist/
