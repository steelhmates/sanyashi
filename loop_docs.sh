#!/bin/bash

set -xe

if sed --version 2>/dev/null | grep -q GNU; then
    SED_INPLACE="sed -i"
else
    SED_INPLACE="sed -i ''"
fi

$SED_INPLACE 's/\\<empty/<empty/' docs/administration/config-cheat-sheet.en-us.md
$SED_INPLACE 's/<empty>/<empty\\>/' docs/administration/config-cheat-sheet.en-us.md
$SED_INPLACE 's/^url:.*//' docs/intro.md
$SED_INPLACE 's/^slug:.*/slug: \//' docs/intro.md
$SED_INPLACE 's/.\/guidelines-frontend.md/.\/guidelines-frontend/' docs/development/hacking-on-gitea.en-us.md
$SED_INPLACE 's/{{< min-node-version >}}/16/' docs/development/hacking-on-gitea.en-us.md
$SED_INPLACE 's/{{< min-go-version >}}/1.20/' docs/development/hacking-on-gitea.en-us.md
$SED_INPLACE 's/{{< go-version >}}/1.20/' docs/development/hacking-on-gitea.en-us.md
$SED_INPLACE 's/{{< min-node-version >}}/16/' docs/installation/from-source.en-us.md
$SED_INPLACE 's/{{< min-go-version >}}/1.20/' docs/installation/from-source.en-us.md

$SED_INPLACE 's/"version":.*/"version":"1.20-dev"/' static/latest-swagger.json

for file in `find ./docs/ -name "*.md"`; do
    # hide hugo toc
    $SED_INPLACE 's/{{< toc >}}//' $file
    $SED_INPLACE 's/dl.gitea.com\/gitea\/{{< version >}}/dl.gitea.com\/gitea\/main/g' $file
    $SED_INPLACE 's/{{< version >}}/main-nightly/g' $file
    $SED_INPLACE 's/{{< relref "doc\///g' $file
    $SED_INPLACE 's/.en-us.md/.md/g' $file
    $SED_INPLACE 's/" >}}//g' $file
    $SED_INPLACE 's/\*\*Table of Contents\*\*//' $file
    $SED_INPLACE 's/weight:/sidebar_position:/g' $file
    #sed -i 's/^slug:.*//' $file
done

for file in docs/*; do
    if [ -d $file ]; then
        continue
    fi
    if [ "$file" == "docs/intro.md" ]; then
        continue
    fi
    rm $file || true
done

for file in `find ./docs/ -name "*.en-us.md"`; do
    mv "${file}" "${file/.en-us/}"
done
