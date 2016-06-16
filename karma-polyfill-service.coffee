polyfillio = require 'polyfill-service'
url = require 'url'


polyfill = ({features = true, path} = {}, files, protocol, hostname, port) ->
  path ?= '/polyfill.js'
  features = default: {} if features == true
  files.unshift
    pattern: "#{protocol}//#{hostname}:#{port}#{path}"
    watch: false
    included: true
    served: false
    nocache: false

  (req, res, next) ->
    {pathname} = url.parse req.url
    return next() unless pathname == path

    polyfillio.getPolyfillString
      uaString: req.headers['user-agent']
      features: features
      unknown: 'polyfill'
    .then (js) ->
      res.setHeader 'Cache-Control', "public, max-age=#{60 * 60}"
      res.setHeader 'Content-Type', 'application/javascript; charset=utf-8'
      res.setHeader 'Vary', 'User-Agent'
      res.end js
    .catch next


polyfill.$inject = ['config.polyfill', 'config.files', 'config.protocol', 'config.hostname', 'config.port']


module.exports = 'middleware:polyfill': ['factory', polyfill]
