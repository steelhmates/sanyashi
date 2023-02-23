#!/bin/bash

set -xe

sed -i 's/<empty/<&#8288;empty/' versioned_docs/version-1.19/advanced/config-cheat-sheet.en-us.md
#sed -i 's/<empty/<&#8288;empty/' versioned_docs/version-1.19/developers/guidelines-backend.en-us.md
sed -i 's/^url:.*//' versioned_docs/version-1.19/intro.md
sed -i 's/^title:.*/displayed_sidebar: mySidebar/' versioned_docs/version-1.19/intro.md
sed -i 's/^slug:.*/slug: \//' versioned_docs/version-1.19/intro.md
sed -i 's/.\/guidelines-frontend.md/.\/guidelines-frontend/' versioned_docs/version-1.19/developers/hacking-on-gitea.en-us.md

sed -i 's/"version":.*/"version":"1.19.5"/' static/18-swagger.json

for file in `find ./versioned_docs/version-1.19/ -name "*.md"`; do
    # note only works on linux, forget about it when attempting to run on macos
    # hide hugo toc
    sed -i 's/{{< toc >}}//' $file
    sed -i 's/{{< version >}}/1.19.5/g' $file
    sed -i 's/{{< relref "doc/\/docs/g' $file
    sed -i 's/" >}}//g' $file
    sed -i 's/\*\*Table of Contents\*\*//' $file
done

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
