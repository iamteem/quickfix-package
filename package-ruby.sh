#!/bin/bash

rm -rf quickfix-ruby/lib
rm -rf quickfix-ruby/ext/quickfix/*.h
rm -rf quickfix-ruby/ext/quickfix/*.hpp
rm -rf quickfix-ruby/ext/quickfix/*.cpp
rm -rf quickfix-ruby/test
rm -rf quickfix-ruby/spec
rm -rf quickfix-ruby/*.gem

mkdir -p quickfix-ruby/lib
mkdir -p quickfix-ruby/ext/quickfix
mkdir -p quickfix-ruby/ext/quickfix/double-conversion
mkdir -p quickfix-ruby/test
mkdir -p quickfix-ruby/spec

rm -rf quickfix
echo "Cloning repo..."
git clone --depth 1 -b v1.15.1a https://github.com/iamteem/quickfix.git
rm -rf quickfix/.git

cp quickfix/LICENSE quickfix-ruby/

cp quickfix/src/ruby/quickfix*.rb quickfix-ruby/lib
cp quickfix/src/C++/*.h quickfix-ruby/ext/quickfix
cp quickfix/src/C++/*.hpp quickfix-ruby/ext/quickfix
cp quickfix/src/C++/*.cpp quickfix-ruby/ext/quickfix
cp quickfix/src/C++/double-conversion/* quickfix-ruby/ext/quickfix/double-conversion
cp quickfix/src/ruby/QuickfixRuby.cpp quickfix-ruby/ext/quickfix
cp quickfix/src/ruby/QuickfixRuby.h quickfix-ruby/ext/quickfix
cp quickfix/src/ruby/test/*TestCase.rb quickfix-ruby/test

cp quickfix/spec/FIX*.xml quickfix-ruby/spec

touch quickfix-ruby/ext/quickfix/config.h
touch quickfix-ruby/ext/quickfix/config_windows.h
rm -f quickfix-ruby/ext/quickfix/stdafx.*

pushd quickfix-ruby/test
for file in * ;
do
mv "$file" "test_$file"
done
popd

pushd quickfix-ruby

gem build quickfix.gemspec
