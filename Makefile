ifeq ($(shell sed --version 2>/dev/null | grep -q GNU && echo gnu),gnu)
	SED_INPLACE := sed -i
else
	SED_INPLACE := sed -i ''
endif

.PHONY: all
all: build

.PHONY: create_dir
create_dir:
	mkdir -p .tmp docs versioned_docs

.PHONY: clone_main
clone_main: create_dir
	git clone --filter=blob:none --no-checkout https://github.com/go-gitea/gitea.git .tmp/upstream-docs-latest
	cur_path=`pwd`
	cd .tmp/upstream-docs-latest
	git config core.sparsecheckout true
	echo "docs/*" > .git/info/sparse-checkout
	git checkout
	cd docs && make trans-copy
	cd $(cur_path)
	bash check_outdated.sh latest zh-cn

.PHONY: prepare-latest
prepare-latest: clone_main
	cp -r .tmp/upstream-docs-latest/docs/static/* static/
	rsync -avz --prune-empty-dirs --include '*/' --include='*.en-us.md' --exclude '*' .tmp/upstream-docs-latest/docs/content/doc/ docs/
	cp .tmp/upstream-docs-latest/docs/content/page/index.en-us.md docs/intro.md
	cp .tmp/upstream-docs-latest/templates/swagger/v1_json.tmpl static/latest-swagger.json
	bash loop_docs.sh

.PHONY: prepare-latest-zh-cn
prepare-latest-zh-cn:
	# clone_main
	# cp -r .tmp/upstream-docs-latest/docs/static/* static/
	mkdir -p i18n/zh-cn/docusaurus-plugin-content-docs/current
	rsync -avz --prune-empty-dirs --include '*/' --include='*.zh-cn.md' --exclude '*' .tmp/upstream-docs-latest/docs/content/doc/ i18n/zh-cn/docusaurus-plugin-content-docs/current/
	cp .tmp/upstream-docs-latest/docs/content/page/index.zh-cn.md i18n/zh-cn/docusaurus-plugin-content-docs/current/intro.md
	bash loop_docs-zh-cn.sh

.PHONY: clone_\#%
clone_\#%: create_dir
	git clone --filter=blob:none --no-checkout --branch=release/v1.$* https://github.com/go-gitea/gitea.git .tmp/upstream-docs-$*
	cur_path=`pwd`
	cd .tmp/upstream-docs-$* && git config core.sparsecheckout true
	echo "docs/*" > .git/info/sparse-checkout
	git checkout release/v1.$*
	cd docs && make trans-copy
	cd $(cur_path)
	bash check_outdated.sh $* zh-cn

.PHONY: prepare\#%
prepare\#%: clone_\#%
	cp -r .tmp/upstream-docs-$*/docs/static/* static/
	rsync -a --prune-empty-dirs --include '*/' --include='*.en-us.md' --exclude '*' .tmp/upstream-docs-$*/docs/content/doc/ versioned_docs/version-1.$*/
	cp .tmp/upstream-docs-$*/docs/content/page/index.en-us.md versioned_docs/version-1.$*/intro.md
	cp .tmp/upstream-docs-$*/templates/swagger/v1_json.tmpl static/$*-swagger.json
	bash loop_docs-$*.sh
	rm versioned_docs/version-1.$*/help/search.md || true

.PHONY: prepare-zh-cn\#%
prepare-zh-cn\#%:
	# clone_\#%
	# cp -r .tmp/upstream-docs-$*/docs/static/* static/
	mkdir -p i18n/zh-cn/docusaurus-plugin-content-docs/version-1.$*
	rsync -avz --prune-empty-dirs --include '*/' --include='*.zh-cn.md' --exclude '*' .tmp/upstream-docs-$*/docs/content/doc/ i18n/zh-cn/docusaurus-plugin-content-docs/version-1.$*/
	cp .tmp/upstream-docs-19/docs/content/page/index.zh-cn.md i18n/zh-cn/docusaurus-plugin-content-docs/version-1.$*/intro.md
	bash loop_docs-$*-zh-cn.sh
	rm i18n/zh-cn/docusaurus-plugin-content-docs/version-1.$*/help/search.md || true

.PHONY: install
install:
	npm install

.PHONY: build
build: install prepare-latest prepare\#19 prepare-latest-zh-cn prepare-zh-cn\#19
	npm ci
	npm run build

.PHONY: serve
serve: install prepare-latest prepare\#19 prepare-latest-zh-cn prepare-zh-cn\#19
	npm run start

.PHONY: clean
clean:
	rm -rf .tmp
	rm -rf docs
	rm -rf versioned_docs/
	rm -rf static/_*
	rm -rf static/latest-swagger.json
	rm -rf static/19-swagger.json
