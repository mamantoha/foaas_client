require "json"
require "./operations"

module Foaas
  class Response
    include JSON::Serializable

    getter message : String
    getter subtitle : String?
  end

  # A Crystal client for FOAAS (Fuck Off As A Service) - a modern, RESTful, scalable solution
  # to the common problem of telling people to fuck off.
  #
  # ```
  # require "foaas_client"
  #
  # client.rtfm("Me")
  # ```
  #
  # List of [operations](https://foaas.com/operations) with names and fields.
  class Client
    # URL = "https://foaas.dev"
    URL = "https://foaas.alexraskin.com"

    # You don't give a fuck about this method!
    #
    # Just call
    #
    # ```
    # client = Foaas::Client.new
    # ```
    #
    # to say
    #
    # ```
    # client.thanks(from: "%username%")
    # ```
    def initialize
    end

    # Macros in Crystal are a great way of writing DRY code, its almost like using a
    # templating language to write your code. I think the best way to understand is
    # to simply show some code.
    #
    # Here is a macro which looping through the `Foaas::Client::OPERATIONS` hash
    # to define 99 *beautiful* methods for each operation.
    #
    # By the way, macros are evaluated at compile-time, meaning that they have no performance penalty.
    #
    # Macros should be just strong enough to reduce boilerplate code.
    #
    {% for operation in OPERATIONS %}
      # {{ operation["name"].id }}
      #
      # Parameters:
      {% for field in operation["fields"] %}
      # * `{{ field["field"].id }}` {{ field["name"].id }}
      {% end %}
      #
      def {{ operation["url"].split("/").reject(&.empty?)[0].gsub(/-/, "_").id }}(
        {% for field in operation["fields"] %}
          {{ field["field"].id }} : String,
        {% end %}
        *,
        i18n : String? = nil
      )
        template = {{ operation["url"].gsub(/:(\w+)/, "%{\\1}") }}

        hash =
          {{
            operation["fields"].map do |field|
              {field["field"] => field["field"].id}
            end
          }}.reduce({} of String => String) { |acc, hsh| acc.merge(hsh) }

        hash.each { |k, v| hash[k] = URI.encode_path(v) }

        query_params = URI::Params.new
        query_params["i18n"] = i18n if i18n

        url = URL + template % hash

        uri = URI.parse(url)
        uri.query_params = query_params

        headers = HTTP::Headers{"Accept" => "application/json"}

        message(uri, headers)
      end
    {% end %}

    private def message(uri : URI, headers : HTTP::Headers) : Foaas::Response
      response = HTTP::Client.get(uri, headers)
      Response.from_json(response.body)
    end
  end
end
