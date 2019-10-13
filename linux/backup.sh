#!/bin/bash

echo "Enter filename to backup: "
read filename

ls .backup_test > /dev/null || mkdir .backup_test

sha256sum $filename > ./.backup_test/${filename}_hash

cp $filename ./.backup_test

function check {
  if [[ -e ${filename} ]]; then
    hash_origin=`sha256sum $filename`
    hash_backup=`cat ./.backup_test/${filename}_hash`
    if [[ $hash_origin != $hash_backup ]]; then
      echo "File changed!!!"
      echo "What do you want to do? (r - restore/s - skip (owerwrite pervious backup of this file)):"
      read answer
      if [[ $answer == 'r' ]]; then
        cp ./.backup_test/${filename} .
        sha256sum $filename > ./.backup_test/${filename}_hash
      elif [[ $answer == 's' ]]; then
        cp $filename ./.backup_test
        sha256sum $filename > ./.backup_test/${filename}_hash
      fi
    fi
  elif [[ ! -e ${filename} ]]; then
	  echo "File is deleted!!! Do you want to restore it? (y - yes/n - no (backup will be deleted!!!))"
    read answerD
    if [[ $answerD == 'y' ]]; then
      cp ./.backup_test/${filename} .
    elif [[ $answerD != 'y' ]]; then
      rm ./.backup_test/${filename}
      rm ./.backup_test/${filename}_hash
    fi
  fi
}

while true; do
  check
  sleep 10
done
