ifeq ($(shell sed --version 2>/dev/null | grep -q GNU && echo gnu),gnu)
	SED_INPLACE := sed -i
else
	SED_INPLACE := sed -i ''
endif

.PHONY: all
all: build

.PHONY: prepare-latest
prepare-latest:
	mkdir -p .tmp docs
	git clone --depth=1 --branch=main https://github.com/go-gitea/gitea.git .tmp/upstream-docs-latest
	cp -r .tmp/upstream-docs-latest/docs/static/* static/
	rsync -avz --prune-empty-dirs --include '*/' --include='*.en-us.md' --exclude '*' .tmp/upstream-docs-latest/docs/content/doc/ docs/
	cp .tmp/upstream-docs-latest/docs/content/page/index.en-us.md docs/intro.md
	cp .tmp/upstream-docs-latest/templates/swagger/v1_json.tmpl static/latest-swagger.json
	bash loop_docs.sh
	rm docs/help/search.en-us.md
	rm -rf .tmp/upstream-docs-latest

.PHONY: prepare\#%
prepare\#%:
	mkdir -p versioned_docs
	git clone --depth=1 --branch=release/v1.$* https://github.com/go-gitea/gitea.git .tmp/upstream-docs-$*
	cp -r .tmp/upstream-docs-$*/docs/static/* static/
	rsync -a --prune-empty-dirs --include '*/' --include='*.en-us.md' --exclude '*' .tmp/upstream-docs-$*/docs/content/doc/ versioned_docs/version-1.$*/
	cp .tmp/upstream-docs-$*/docs/content/page/index.en-us.md versioned_docs/version-1.$*/intro.md
	cp .tmp/upstream-docs-$*/templates/swagger/v1_json.tmpl static/$*-swagger.json
	bash loop_docs-$*.sh
	rm versioned_docs/version-1.$*/help/search.en-us.md
	rm -rf .tmp/upstream-docs-$*

.PHONY: build
build: prepare-latest prepare\#19
	npm ci
	npm run build

.PHONY: serve
serve: prepare-latest
	npm run serve

.PHONY: clean
clean:
	rm -rf .tmp
	rm -rf node_modules
	rm -rf docs
	rm -rf versioned_docs/
	rm -rf static/_*
	rm -rf static/latest-swagger.json
	rm -rf static/19-swagger.json