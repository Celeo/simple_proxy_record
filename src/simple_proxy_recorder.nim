# https://developer.mozilla.org/en-US/docs/Web/HTTP/Proxy_servers_and_tunneling
# https://stackoverflow.com/questions/10876883/implementing-an-http-proxy

import asyncdispatch, asynchttpserver, strutils
import docopt

const cliDoc = """
Simple proxy recorder.

Usage:
  simple_proxy_record <port>
  simple_proxy_record (-h | --help)
  simple_proxy_record --version

Options:
  -h --help   Show this screen
  --version   Show version
"""

proc callback(req: Request) {.async.} =
  echo("Method: " & $req.reqMethod)
  echo("Url: " & req.url.path)
  echo("Headers: " & $req.headers)
  await req.respond(Http200, "Hello world")

when isMainModule:
  let args = docopt(cliDoc, version = "Simple proxy recorder 0.1.0")
  echo("Setting up server")
  let server = newAsyncHttpServer()
  echo("Running ...")
  waitFor(server.serve(Port(8080), callback))
