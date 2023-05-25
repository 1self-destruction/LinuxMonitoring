#!/bin/bash

if [[ -n $1 ]]
then
  if [[ -n $2 ]]
  then
    echo "Too much parameters"
  else
    string="^[+-]?[0-9]+([.][0-9]+)?$"

    if ! [[ $1 =~ $string ]]
    then
      echo $1
    else
      echo "Incorrect input"
    fi
  fi
else
  echo "no parameters found"
fi
