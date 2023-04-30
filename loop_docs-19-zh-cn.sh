#!/bin/bash

set -xe

if sed --version 2>/dev/null | grep -q GNU; then
    SED_INPLACE="sed -i"
else
    SED_INPLACE="sed -i ''"
fi

$SED_INPLACE 's/</<&#8288;/' versioned_docs/version-1.19/zh-cn/installation/with-docker.zh-cn.md
$SED_INPLACE 's/<empty/<&#8288;empty/' versioned_docs/version-1.19/zh-cn/installation/with-docker.zh-cn.md

$SED_INPLACE 's/</<&#8288;/' versioned_docs/version-1.19/zh-cn/contributing/guidelines-backend.zh-cn.md
$SED_INPLACE 's/</&#8288;/' versioned_docs/version-1.19/zh-cn/contributing/guidelines-backend.zh-cn.md
$SED_INPLACE 's/<empty/<&#8288;empty/' versioned_docs/version-1.19/zh-cn/contributing/guidelines-backend.zh-cn.md

$SED_INPLACE 's/<empty/<&#8288;empty/' versioned_docs/version-1.19/zh-cn/administration/config-cheat-sheet.zh-cn.md

$SED_INPLACE 's/^url:.*//' versioned_docs/version-1.19/zh-cn/intro.md
$SED_INPLACE 's/^title:.*/displayed_sidebar: siderBarCN/' versioned_docs/version-1.19/zh-cn/intro.md
$SED_INPLACE 's/^slug:.*/slug: \/zh-cn\//' versioned_docs/version-1.19/zh-cn/intro.md
$SED_INPLACE 's/.\/guidelines-frontend.md/.\/guidelines-frontend/' versioned_docs/version-1.19/zh-cn/development/hacking-on-gitea.zh-cn.md

$SED_INPLACE 's/"version":.*/"version":"1.19.0"/' static/19-swagger.json

for file in `find ./versioned_docs/version-1.19/zh-cn/ -name "*.md"`; do
    # note only works on linux, forget about it when attempting to run on macos
    # hide hugo toc
    $SED_INPLACE 's/{{< toc >}}//' $file
    $SED_INPLACE 's/{{< version >}}/1.19.0/g' $file
    $SED_INPLACE 's/{{< relref "doc/\/docs\/zh-cn/g' $file
    $SED_INPLACE 's/" >}}//g' $file
    $SED_INPLACE 's/\*\*Table of Contents\*\*//' $file
    $SED_INPLACE 's/weight:/sidebar_position:/g' $file
done

for file in `find ./versioned_docs/version-1.19/zh-cn/usage/ -name "*.md"`; do
    # note only works on linux, forget about it when attempting to run on macos
    # hide hugo toc
    $SED_INPLACE 's/title:.*//' $file
done

for file in versioned_docs/version-1.19/zh-cn/*; do
    if [ -d $file ]; then
        continue
    fi
    if [ "$file" == "versioned_docs/version-1.19/zh-cn/intro.md" ]; then
        continue
    fi
    rm $file
done

# for file in `find ./versioned_docs/version-1.19/zh-cn/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done
# for file in `find ./i18n/zh-tw/docusaurus-plugin-content-docs/version-1.19/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done
# for file in `find ./i18n/fr-fr/docusaurus-plugin-content-docs/version-1.19/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done
# for file in `find ./i18n/zh-cn/docusaurus-plugin-content-docs/version-1.19/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done