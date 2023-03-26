#!/bin/bash

set -xe

sed -i 's/<empty/<&#8288;empty/' versioned_docs/version-1.19/administration/config-cheat-sheet.en-us.md
sed -i 's/^url:.*//' versioned_docs/version-1.19/intro.md
sed -i 's/^title:.*/displayed_sidebar: mySidebar/' versioned_docs/version-1.19/intro.md
sed -i 's/^slug:.*/slug: \//' versioned_docs/version-1.19/intro.md
sed -i 's/.\/guidelines-frontend.md/.\/guidelines-frontend/' versioned_docs/version-1.19/development/hacking-on-gitea.en-us.md

sed -i 's/"version":.*/"version":"1.19.0"/' static/19-swagger.json

for file in `find ./versioned_docs/version-1.19/ -name "*.md"`; do
    # note only works on linux, forget about it when attempting to run on macos
    # hide hugo toc
    sed -i 's/{{< toc >}}//' $file
    sed -i 's/{{< version >}}/1.18.5/g' $file
    sed -i 's/{{< relref "doc/\/docs/g' $file
    sed -i 's/" >}}//g' $file
    sed -i 's/\*\*Table of Contents\*\*//' $file
    sed -i 's/weight:/sidebar_position:/g' $file
    sed -i 's/^slug:.*///' $file
done

sed -i 's/</&#8288;/' versioned_docs/version-1.19/contributing/guidelines-backend.en-us.md

for file in `find ./versioned_docs/version-1.19/usage/ -name "*.md"`; do
    # note only works on linux, forget about it when attempting to run on macos
    # hide hugo toc
    sed -i 's/title:.*//' $file
done

for file in versioned_docs/version-1.19/*; do
    if [ -d $file ]; then
        continue
    fi
    if [ "$file" == "versioned_docs/version-1.19/intro.md" ]; then
        continue
    fi
    rm $file
done

# for file in `find ./versioned_docs/version-1.19/ -name "*.md"`; do
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
