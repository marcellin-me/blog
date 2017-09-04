#!/bin/bash
rm -rf out && mkdir out
cp -rf deployment-files/_config.yml .
bundle exec jekyll build
cp -rf _site/* out/
ls -al out
cp -rf out/* ~/mystery-home/products/www/marcellin/public/blog/
cp -rf locals/_config.yml .
