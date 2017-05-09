#!/usr/bin/env bash
cd $(dirname $0)/..

mkdir -p medline
cat literature.tsv \
    | cut -f1,3 \
    | tr ' ' '-' \
    | parallel --header : --verbose --jobs 1 \
        esearch -db pubmed -query \''{JID}[JID] AND ("2017/01/01"[EDAT] : "2017/12/31"[EDAT])'\' \
        '|' efetch -format medline \
        '>' medline/{TA}.txt
