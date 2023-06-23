#!/bin/bash

# The script takes two params: 
#     version: "latest" or a specific version number
#     locale

set -xe

SED_INPLACE() {
  if sed --version 2>/dev/null | grep -q GNU; then
    sed -i "$@"
  else
    sed -i '' "$@"
  fi
}

version="$1"
if [ "$version" != "lastest" ]; then
    version="1.$1"
fi
locale="$2"
minNodeVer="16"
minGoVer="1.20"
goVer="1.20"
minorVer="main-nightly"
if ["$version" == "1.19"]; then
    minorVer="1.19.3"
    minGoVer="1.19"
elif ["$version" == "1.20"]; then
    minorVer="1.20.0-rc1"
fi

docs_dir="versioned_docs/version-$version"
if [ "$version" == "lastest" ]; then
    if [ "$locale" == "en-us" ]; then
        docs_dir="docs"
    else
        docs_dir="i18n/$locale/docusaurus-plugin-content-docs/current"
    fi
else
    if [ "$locale" != "en-us" ]; then
        docs_dir="i18n/$locale/docusaurus-plugin-content-docs/version-$version"
    fi
fi

if [ -f "$docs_dir/installation/with-docker.$locale.md" ]; then
    SED_INPLACE 's/\\<empty>/<empty\\>/' "$docs_dir/installation/with-docker.$locale.md"
fi
SED_INPLACE 's/\\<empty/<empty/' "$docs_dir/administration/config-cheat-sheet.$locale.md"
SED_INPLACE 's/<empty>/<empty\\>/' "$docs_dir/administration/config-cheat-sheet.$locale.md"
SED_INPLACE 's/^url:.*//' "$docs_dir/intro.md"
SED_INPLACE 's/^slug:.*/slug: \//' "$docs_dir/intro.md"
SED_INPLACE "s/{{< min-node-version >}}/$minNodeVer/" "$docs_dir/development/hacking-on-gitea.$locale.md"
SED_INPLACE "s/{{< min-go-version >}}/$minGoVer/" "$docs_dir/development/hacking-on-gitea.$locale.md"
SED_INPLACE "s/{{< go-version >}}/$goVer/" "$docs_dir/development/hacking-on-gitea.$locale.md"
SED_INPLACE "s/{{< min-node-version >}}/$minNodeVer/" "$docs_dir/installation/from-source.$locale.md"
SED_INPLACE "s/{{< min-go-version >}}/$minGoVer/" "$docs_dir/installation/from-source.$locale.md"

# TODO: improve this sed
# need confirmation
if [ "$version" == "lastest" ]; then
    SED_INPLACE 's/"version":.*/"version":"1.21-dev"/' static/latest-swagger.json
elif [ "$version" == "1.20" ]; then
    SED_INPLACE 's/"version":.*/"version":"1.20.0-rc0"/' static/20-swagger.json
elif [ "$version" == "1.19" ]; then
    SED_INPLACE 's/"version":.*/"version":"1.19.3"/' static/19-swagger.json
fi

for file in `find ./"$docs_dir" -name "*.md"`; do
    # hide hugo toc
    SED_INPLACE 's/{{< toc >}}//' $file
    SED_INPLACE 's/dl.gitea.com\/gitea\/{{< version >}}/dl.gitea.com\/gitea\/main/g' $file
    SED_INPLACE "s/{{< version >}}/$minorVer/g" $file
    SED_INPLACE 's/{{< relref "doc\///g' $file
    SED_INPLACE "s/.$locale.md/.md/g" $file
    SED_INPLACE 's/" >}}//g' $file
    SED_INPLACE 's/\*\*Table of Contents\*\*//' $file
    SED_INPLACE 's/weight:/sidebar_position:/g' $file
    #sed -i 's/^slug:.*//' $file
done

for file in "$docs_dir"/*; do
    if [ -d $file ]; then
        continue
    fi
    if [ "$file" == "$docs_dir/intro.md" ]; then
        continue
    fi
    rm $file || true
done

# file names under docs/ and i18n/zh-cn/docusaurus-plugin-content-docs/current/ should be the same for docusaurus 
# to recognize them as tanslated.
for file in `find "$docs_dir" -name "*.$locale.md"`; do
    mv "${file}" "${file/.$locale/}"
done

if [ -f "$docs_dir/help/search.md" ]; then
    rm "$docs_dir/help/search.md"
fi
