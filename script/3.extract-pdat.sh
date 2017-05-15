#!/usr/bin/env bash
cd $(dirname $0)/..

ls medline/*.txt \
    | grep -v 'pdat' \
    | parallel --verbose --jobs 1 \
        grep ^EDAT {} '|' cut -d\' \' -f2 '|' tr / - '|' sort '>' {.}.edat.txt
