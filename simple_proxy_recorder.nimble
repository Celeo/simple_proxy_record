version       = "0.1.0"
author        = "Celeo"
description   = "A simple HTTP proxy that saves requests and responses"
license       = "MIT"
srcDir        = "src"
bin           = @["simple_proxy_recorder"]

requires "nim >= 1.0.4"
requires "docopt >= 0.6.8"
# requires "https://github.com/celeo/http_har.git"
requires "http_har >= 0.1.2"
