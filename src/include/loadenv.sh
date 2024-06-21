#!/bin/bash
if [ -f .env ]
then
    source <(cat .env | sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" )
fi
