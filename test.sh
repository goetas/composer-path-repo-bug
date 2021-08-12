#!/bin/bash

set -e

rm -rf test_run
mkdir -p test_run
cp -r pkg test_run/
cp -r v1 test_run/
cp -r v2 test_run/

pushd test_run
echo "Get composer"
pushd v1
wget https://getcomposer.org/download/1.10.22/composer.phar
popd

pushd v2
wget https://getcomposer.org/download/2.1.5/composer.phar
popd

echo "Generate lock files"
pushd v1
php composer.phar update
popd

pushd v2
php composer.phar update
popd

echo
echo "Tests:"

echo
echo "1. Empty pkg directory"
rm pkg/*

pushd v1
rm -rf vendor
php composer.phar install  --no-progress
echo
echo "Composer v1"
ls -la vendor/goetas
popd


pushd v2
rm -rf vendor
php composer.phar install  --no-progress
echo
echo "Composer v2"
ls -la vendor/goetas
popd


echo
echo "2. Add just one file"
touch pkg/some_file

pushd v1
rm -rf vendor
php composer.phar install --no-progress
echo
echo "Composer v1"
ls -la vendor/goetas
popd


pushd v2
rm -rf vendor
php composer.phar install  --no-progress
echo
echo "Composer v2"
ls -la vendor/goetas
popd

