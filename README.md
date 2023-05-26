# Gitea Docusaurus

## How to build

```shell
make clean
make build
```

## Development

```shell
make clean
make serve
```

## Test en version

```
npm run start
```

## Test zh-cn version

```
npm run start -- --locale zh-cn
```

## Translate presets for zh-cn version

```
npx docusaurus write-translations --locale zh-cn
```

## Test both zh-cn and en versions

```
npm run build
npm run serve
```
