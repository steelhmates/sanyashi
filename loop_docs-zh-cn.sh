#!/bin/bash

set -xe

if sed --version 2>/dev/null | grep -q GNU; then
    SED_INPLACE="sed -i"
else
    SED_INPLACE="sed -i ''"
fi

$SED_INPLACE 's/</<&#8288;/' i18n/zh-cn/docusaurus-plugin-content-docs/current/installation/with-docker.zh-cn.md
$SED_INPLACE 's/<empty/<&#8288;empty/' i18n/zh-cn/docusaurus-plugin-content-docs/current/installation/with-docker.zh-cn.md

$SED_INPLACE 's/</<&#8288;/' i18n/zh-cn/docusaurus-plugin-content-docs/current/contributing/guidelines-backend.zh-cn.md
$SED_INPLACE 's/</&#8288;/' i18n/zh-cn/docusaurus-plugin-content-docs/current/contributing/guidelines-backend.zh-cn.md
$SED_INPLACE 's/<empty/<&#8288;empty/' i18n/zh-cn/docusaurus-plugin-content-docs/current/contributing/guidelines-backend.zh-cn.md

$SED_INPLACE 's/<empty/<&#8288;empty/' i18n/zh-cn/docusaurus-plugin-content-docs/current/administration/config-cheat-sheet.zh-cn.md

$SED_INPLACE 's/^url:.*//' i18n/zh-cn/docusaurus-plugin-content-docs/current/intro.md
$SED_INPLACE 's/^slug:.*/slug: \//' i18n/zh-cn/docusaurus-plugin-content-docs/current/intro.md
$SED_INPLACE 's/.\/guidelines-frontend.md/.\/guidelines-frontend/' i18n/zh-cn/docusaurus-plugin-content-docs/current/development/hacking-on-gitea.zh-cn.md

$SED_INPLACE 's/"version":.*/"version":"1.20-dev"/' static/latest-swagger.json

for file in `find ./i18n/zh-cn/docusaurus-plugin-content-docs/current/ -name "*.md"`; do
    # note only works on linux, forget about it when attempting to run on macos
    # hide hugo toc
    $SED_INPLACE 's/{{< toc >}}//' $file
    $SED_INPLACE 's/{{< version >}}/1.18.2/g' $file
    $SED_INPLACE 's/{{< relref "doc/i18n\/zh-cn\/docusaurus-plugin-content-docs\/current/g' $file
    $SED_INPLACE 's/" >}}//g' $file
    $SED_INPLACE 's/\*\*Table of Contents\*\*//' $file
    $SED_INPLACE 's/weight:/sidebar_position:/g' $file
done

for file in i18n/zh-cn/docusaurus-plugin-content-docs/current/*; do
    if [ -d $file ]; then
        continue
    fi
    if [ "$file" == "i18n/zh-cn/docusaurus-plugin-content-docs/current/intro.md" ]; then
        continue
    fi
    rm $file
done

for file in `find ./i18n/zh-cn/docusaurus-plugin-content-docs/current/ -name "*.zh-cn.md"`; do
    mv "${file}" "${file/.zh-cn/}"
done

# for file in `find ./i18n/zh-cn/docusaurus-plugin-content-docs/current/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done

# for file in `find ./i18n/zh-tw/docusaurus-plugin-content-docs/zh-cn/current/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done
# for file in `find ./i18n/fr-fr/docusaurus-plugin-content-docs/zh-cn/current/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done
# for file in `find ./i18n/zh-cn/docusaurus-plugin-content-docs/zh-cn/current/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done
