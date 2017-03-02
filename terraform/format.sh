#!/usr/bin/env bash

# Run basic syntax and format checks, return 1 if anything fails

exitcode=0
modules=$(find . -type f -name \*.tf | xargs -I % dirname % | uniq)

for m in $modules; do
  terraform fmt $m
done
