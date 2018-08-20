#!/bin/bash

# Delete old gitignore and init the new one
rm -rf ./.gitignore
touch ./.gitignore
echo 'site' >> ./.gitignore

for path in scripts/*.sh;
  do full_filename=`basename $path`;
  filename=`echo ${full_filename%.*}`;
  cp scripts/$filename.sh docs/scripts/$filename.md
  echo '```bash' | cat - docs/scripts/$filename.md > temp && mv temp docs/scripts/$filename.md
  printf '\n```' >> docs/scripts/$filename.md

  # add generated files to gitignore
  echo $filename'.md' >> ./.gitignore;
done
