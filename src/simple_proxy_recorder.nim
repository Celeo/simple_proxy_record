import asyncdispatch,
  httpclient,
  asynchttpserver,
  strutils,
  strformat
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
  let client = newAsyncHttpClient()
  let newUrl = req.url.scheme & "://" & req.headers["host"] & req.url.path
  echo("Forwarding call to " & newUrl)

  var newHeaders = req.headers
  newHeaders.table.del("host")
  let response = await client.request(newUrl, req.reqMethod, body = "", headers = newHeaders)

  await req.respond(response.code(), await response.body, response.headers)

when isMainModule:
  let args = docopt(cliDoc, version = "Simple proxy recorder 0.1.0")
  let port = ($args["<port>"]).parseInt()
  let server = newAsyncHttpServer()
  echo(&"Running on port {$port}...")
  waitFor(server.serve(Port(port), callback))
