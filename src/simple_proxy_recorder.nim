import asyncdispatch,
  asynchttpserver,
  httpclient,
  os,
  strutils,
  strformat
import docopt, http_har

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

proc nextFile(): int =
  var highest = 0
  for f in walkFiles("*.har"):
    let name = f.replace(".har", "")
    try:
      highest = max(highest, name.parseInt())
    except:
      discard
  highest + 1

proc callback(req: Request) {.async.} =
  let client = newAsyncHttpClient()
  let newUrl = req.url.scheme & "://" & req.headers["host"] & req.url.path
  echo("Forwarding call to " & newUrl)

  var newHeaders = req.headers
  newHeaders.table.del("host")
  let resp = await client.request(newUrl, req.reqMethod, body = "", headers = newHeaders)

  let har = await convertAsync(req, resp)
  let fname = &"{nextFile()}.har"
  echo(&"Writing HAR to {fname}")
  writeFile(fname, har)

  await req.respond(resp.code(), await resp.body, resp.headers)

when isMainModule:
  let args = docopt(cliDoc, version = "Simple proxy recorder 0.1.0")
  let port = ($args["<port>"]).parseInt()
  let server = newAsyncHttpServer()
  echo(&"Running on port {$port}...")
  waitFor(server.serve(Port(port), callback))
