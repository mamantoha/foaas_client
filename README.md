# FOAAS Client

[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://mamantoha.github.io/foaas_client/)

A Crystal client for [FOAAS](https://foaas.com)(Fuck Off As A Service) - a modern, RESTful, scalable solution to the common problem of telling people to fuck off.

> This library was writter to demonstrate a powerful macro system in [Crystal](https://crystal-lang.org/).

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  foaas_client:
    github: mamantoha/foaas_client
```

## API Version

Version `1.1.1` of the FOAAS API is supported.

## Usage

```crystal
require "foaas_client"

client = Foaas::Client.new

client.rtfm("Me")
# => Read the fucking manual! - Me

client.awesome("You", accept_type: :text)
# => This is Fucking Awesome. - You

client.you("Nvidia", "Linus Torvalds", accept_type: :text)
# => Fuck you, Nvidia. - Linus Torvalds

client.dosomething("Do", "work", "Ruby", accept_type: :text)
# => Do the fucking work! - Ruby
```

Will respond to the following `accept_type` values:

* `:text` - Content will be returned as a plain string.
* `:json` - Content will be returned as a JSON object.
* `:html` - Content will be returned as an HTML page with a twitter bootstrap hero unit, containing the message and the subtitle.
* `:xml` - Content will be returned as a XML document.

## Development

```console
crystal utils/generate_operations.cr
crystal tool format
```

## Contributing

1. Fork it ( https://github.com/mamantoha/foaas_client/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

* [mamantoha](https://github.com/mamantoha) Anton Maminov - creator, maintainer
