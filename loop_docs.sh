#!/bin/bash

set -xe

sed -i 's/<empty/<&#8288;empty/' docs/advanced/config-cheat-sheet.en-us.md
sed -i 's/<empty/<&#8288;empty/' docs/developers/guidelines-backend.en-us.md
sed -i 's/</<&#8288;/' docs/developers/guidelines-backend.en-us.md
sed -i 's/<>/<&#8288;>/' docs/developers/guidelines-backend.en-us.md
sed -i 's/^url:.*//' docs/intro.md
sed -i 's/^title:.*/displayed_sidebar: mySidebar/' docs/intro.md
sed -i 's/^slug:.*/slug: \//' docs/intro.md
sed -i 's/.\/guidelines-frontend.md/.\/guidelines-frontend/' docs/developers/hacking-on-gitea.en-us.md

sed -i 's/"version":.*/"version":"1.20-dev"/' static/latest-swagger.json

for file in `find ./docs/ -name "*.md"`; do
    # note only works on linux, forget about it when attempting to run on macos
    # hide hugo toc
    sed -i 's/{{< toc >}}//' $file
    sed -i 's/{{< version >}}/1.18.5/g' $file
    sed -i 's/{{< relref "doc/\/docs/g' $file
    sed -i 's/" >}}//g' $file
    sed -i 's/\*\*Table of Contents\*\*//' $file
done

for file in `find ./docs/usage/ -name "*.md"`; do
    # note only works on linux, forget about it when attempting to run on macos
    # hide hugo toc
    sed -i 's/title:.*//' $file
done

for file in docs/*; do
    if [ -d $file ]; then
        continue
    fi
    if [ "$file" == "docs/intro.md" ]; then
        continue
    fi
    rm $file
done


# for file in `find ./docs/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done

# for file in `find ./i18n/zh-tw/docusaurus-plugin-content-docs/current/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done
# for file in `find ./i18n/fr-fr/docusaurus-plugin-content-docs/current/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done
# for file in `find ./i18n/zh-cn/docusaurus-plugin-content-docs/current/ -name "*.md"`; do
#     trimmed=$(echo $file | cut -f 2 -d '.')
#     mv $file .$trimmed.md
# done
