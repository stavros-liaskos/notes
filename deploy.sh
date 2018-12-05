#!/bin/bash

cp README.md docs/
bash script2md.sh
mkdocs gh-deploy
