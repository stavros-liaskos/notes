#!/bin/bash

# Delete old gitignore and init the new one
rm -rf ./.gitignore
touch ./.gitignore
echo 'site' >> ./.gitignore

for path in scripts/*.sh;
  do full_filename=`basename $path`;
  filename=`echo ${full_filename%.*}`;
  cp scripts/$filename.sh docs/$filename.md
  echo '```bash' | cat - docs/$filename.md > temp && mv temp docs/$filename.md
  printf '\n```' >> docs/$filename.md

  # add generated files to gitignore
  echo $filename'.md' >> ./.gitignore;
done
