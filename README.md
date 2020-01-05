# simple_proxy_recorder

A simple HTTP proxy that saves requests and responses into HAR files.

## Building

Uses [Nim](https://nim-lang.org/).

```sh
git clone https://github.com/celeo/simple_proxy_recorder
cd simple_proxy_recorder
nimble build
```

## Downloading

```sh
nimble install "https://github.com/celeo/simple_proxy_recorder.git"
```

## Using

```sh
❯ ./simple_proxy_recorder -h
Simple proxy recorder.

Usage:
  simple_proxy_record <port>
  simple_proxy_record (-h | --help)
  simple_proxy_record --version

Options:
  -h --help   Show this screen
  --version   Show version
```
