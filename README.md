# karma-polyfill-service

[karma](https://github.com/karma-runner/karma) plugin (middleware) for automatic polyfill injection using [polyfill-service](https://github.com/Financial-Times/polyfill-service).

## Installation

```shell
npm install --save karma-polyfill-service
```

## Usage

```coffeescript
# add the middleware and its config to your karma config:
middleware: ['polyfill']
polyfill:
  features: <feature-set> # feature set, see polyfill-service docs for details, defaults to `{default: {}}`
  path: '<path>' # path to serve the polyfill script under, defaults to '/polyfill.js'
# that's it, now your test environment is patched w/ the polyfills
```
