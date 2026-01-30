# FOAAS Client

[![Crystal CI](https://github.com/mamantoha/foaas_client/actions/workflows/crystal.yml/badge.svg)](https://github.com/mamantoha/foaas_client/actions/workflows/crystal.yml)
[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://mamantoha.github.io/foaas_client/)

A Crystal client for [FOAAS](https://github.com/tomdionysus/foaas)(Fuck Off As A Service) - a modern, RESTful, scalable solution to the common problem of telling people to fuck off.

> This library was writter to demonstrate a powerful macro system in [Crystal](https://crystal-lang.org/).

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  foaas_client:
    github: mamantoha/foaas_client
```

## API Version

Version `2.3.2` of the FOAAS API is supported.

## Usage

```crystal
require "foaas_client"

client = Foaas::Client.new

client.rtfm("Me")
# => #<Foaas::Response:0x7fe964a10a80 @message="Read the fucking manual!", @subtitle="- Me">

client.awesome("You")
# => #<Foaas::Response:0x7fe964a10900 @message="This is Fucking Awesome.", @subtitle="- You">

client.you("Nvidia", "Linus Torvalds")
# => #<Foaas::Response:0x7fe964a10760 @message="Fuck you, Nvidia.", @subtitle="- Linus Torvalds">

client.dosomething("Do", "work", "Ruby")
# => #<Foaas::Response:0x7fe964a10ae0 @message="Do the fucking work!", @subtitle="- Ruby">

client.awesome("Everyone", i18n: "uk")
# => #<Foaas::Response:0x7fe964a10940 @message="Це, чорт забирай, класно. Усі ", @subtitle=" undefined">
```

## Development

```console
crystal ./utils/generate_operations.cr
```

## Contributing

1. Fork it ( https://github.com/mamantoha/foaas_client/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [mamantoha](https://github.com/mamantoha) Anton Maminov - creator, maintainer
