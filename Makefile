export NODE_OPTIONS := "--max-old-space-size=8192"

.PHONY: all
all: build

.PHONY: create_dir
create_dir:
	mkdir -p .tmp docs versioned_docs awesome

.PHONY: clone
clone: create_dir
	git clone https://github.com/go-gitea/gitea.git .tmp/upstream-docs || true

.PHONY: clone_awesome
clone_awesome: create_dir
	git clone --branch=main https://gitea.com/gitea/awesome-gitea.git .tmp/upstream-awesome || true

.PHONY: prepare-awesome-latest
prepare-awesome-latest: clone_awesome
	cp .tmp/upstream-awesome/README.md docs/awesome.md

.PHONY: prepare-awesome\#%
prepare-awesome\#%:
	cp .tmp/upstream-awesome/README.md  versioned_docs/version-1.$*/awesome.md

.PHONY: clone_main
clone_main: clone
	cd .tmp/upstream-docs && git clean -f && git reset --hard && git checkout main
	cur_path=`pwd`
	cd .tmp/upstream-docs/docs && bash scripts/trans-copy.sh
	cd $(cur_path)
	bash check_outdated.sh zh-cn

.PHONY: prepare-latest
prepare-latest: clone_main
	cp -r .tmp/upstream-docs/docs/static/* static/
	rsync -avz --prune-empty-dirs --include '*/' --include='*.en-us.md' --exclude '*' .tmp/upstream-docs/docs/content/ docs/
	cp .tmp/upstream-docs/docs/content/index.en-us.md docs/intro.md
	cp .tmp/upstream-docs/templates/swagger/v1_json.tmpl static/swagger-latest.json
	bash loop_docs.sh latest en-us

.PHONY: prepare-latest-zh-cn
prepare-latest-zh-cn:
	mkdir -p i18n/zh-cn/docusaurus-plugin-content-docs/current
	rsync -avz --prune-empty-dirs --include '*/' --include='*.zh-cn.md' --exclude '*' .tmp/upstream-docs/docs/content/ i18n/zh-cn/docusaurus-plugin-content-docs/current/
	cp .tmp/upstream-docs/docs/content/index.zh-cn.md i18n/zh-cn/docusaurus-plugin-content-docs/current/intro.md
	bash loop_docs.sh latest zh-cn

.PHONY: clone_\#%
clone_\#%: clone
	cd .tmp/upstream-docs && git clean -f && git reset --hard && git checkout release/v1.$*
	cur_path=`pwd`
	cd .tmp/upstream-docs/docs && bash scripts/trans-copy.sh
	cd $(cur_path)
	bash check_outdated.sh zh-cn

.PHONY: prepare\#%
prepare\#%: clone_\#%
	cp -r .tmp/upstream-docs/docs/static/* static/
	rsync -a --prune-empty-dirs --include '*/' --include='*.en-us.md' --exclude '*' .tmp/upstream-docs/docs/content/ versioned_docs/version-1.$*/
	cp .tmp/upstream-docs/docs/content/index.en-us.md versioned_docs/version-1.$*/intro.md
	cp .tmp/upstream-docs/templates/swagger/v1_json.tmpl static/swagger-$*.json
	bash loop_docs.sh $* en-us

.PHONY: prepare-zh-cn\#%
prepare-zh-cn\#%:
	mkdir -p i18n/zh-cn/docusaurus-plugin-content-docs/version-1.$*
	rsync -avz --prune-empty-dirs --include '*/' --include='*.zh-cn.md' --exclude '*' .tmp/upstream-docs/docs/content/ i18n/zh-cn/docusaurus-plugin-content-docs/version-1.$*/
	cp .tmp/upstream-docs/docs/content/index.zh-cn.md i18n/zh-cn/docusaurus-plugin-content-docs/version-1.$*/intro.md
	bash loop_docs.sh $* zh-cn

.PHONY: install
install:
	npm install

.PHONY: prepare-docs
prepare-docs: install prepare-latest prepare\#21 prepare\#20 prepare\#19 prepare-latest-zh-cn prepare-zh-cn\#21 prepare-zh-cn\#20 prepare-zh-cn\#19 prepare-awesome-latest prepare-awesome\#19 prepare-awesome\#20 prepare-awesome\#21

.PHONY: build
build:
	npm ci
	npm run build

.PHONY: serve
serve: prepare-docs
	npm run start

.PHONY: clean
clean:
	rm -rf .tmp
	rm -rf docs
	rm -rf versioned_docs/
	rm -rf static/_*
	rm -rf static/swagger-latest.json
	rm -rf static/swagger-19.json
	rm -rf static/swagger-20.json
	rm -rf static/swagger-21.json
