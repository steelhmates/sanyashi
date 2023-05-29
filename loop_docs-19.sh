#!/bin/bash

set -xe

if sed --version 2>/dev/null | grep -q GNU; then
    SED_INPLACE="sed -i"
else
    SED_INPLACE="sed -i ''"
fi

$SED_INPLACE 's/<empty/<&#8288;empty/' versioned_docs/version-1.19/administration/config-cheat-sheet.en-us.md
$SED_INPLACE 's/^url:.*//' versioned_docs/version-1.19/intro.md
$SED_INPLACE 's/^slug:.*/slug: \//' versioned_docs/version-1.19/intro.md
$SED_INPLACE 's/.\/guidelines-frontend.md/.\/guidelines-frontend/' versioned_docs/version-1.19/development/hacking-on-gitea.en-us.md

$SED_INPLACE 's/"version":.*/"version":"1.19.3"/' static/19-swagger.json

for file in `find ./versioned_docs/version-1.19/ -name "*.md"`; do
    # hide hugo toc
    $SED_INPLACE 's/{{< toc >}}//' $file
    $SED_INPLACE 's/{{< version >}}/1.19.3/g' $file
    $SED_INPLACE 's/{{< relref "doc\///g' $file
    $SED_INPLACE 's/.en-us.md/.md/g' $file
    $SED_INPLACE 's/" >}}//g' $file
    $SED_INPLACE 's/\*\*Table of Contents\*\*//' $file
    $SED_INPLACE 's/weight:/sidebar_position:/g' $file
    #sed -i 's/^slug:.*//' $file
done

$SED_INPLACE 's/</&#8288;/' versioned_docs/version-1.19/contributing/guidelines-backend.en-us.md

for file in versioned_docs/version-1.19/*; do
    if [ -d $file ]; then
        continue
    fi
    if [ "$file" == "versioned_docs/version-1.19/intro.md" ]; then
        continue
    fi
    rm $file
done

for file in `find ./versioned_docs/version-1.19/ -name "*.en-us.md"`; do
    mv "${file}" "${file/.en-us/}"
done
