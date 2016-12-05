#!/bin/bash
if [ $1 -eq "1" ]; then
  echo "Iniciar";
  ./start i;
  exit 0;
fi

if [ $1 -eq "2" ]; then
  echo "Parar";
  ./start p;
  exit 0;
fi
