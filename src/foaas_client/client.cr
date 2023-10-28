require "./operations"

module Foaas
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
    URL = "https://web-production-d32f.up.railway.app"

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
      # {{operation["name"].id}}
      #
      # Parameters:
      {% for field in operation["fields"] %}
      # * `{{field["field"].id}}` {{field["name"].id}}
      {% end %}
      #
      def {{operation["url"].split("/").reject(&.empty?)[0].gsub(/-/, "_").id}}(
        {% for field in operation["fields"] %}
          {{field["field"].id}} : String,
        {% end %}
        *,
        accept_type = :text
      )
        template = {{operation["url"].gsub(/:(\w+)/, "%{\\1}")}}

        hash = {{operation["fields"].map { |f| {f["field"] => f["field"].id} }}}.reduce({} of String => String) { |acc, hsh| acc.merge(hsh) }
        hash.each { |k, v| hash[k] = URI.encode_path(v) }

        url = URL + template % hash
        headers = headers(accept_type)

        make_request(url, headers)
      end
    {% end %}

    private def make_request(url : String, headers : HTTP::Headers)
      response = HTTP::Client.get(url, headers)
      response.body
    end

    private def headers(accept_type : Symbol)
      accept = case accept_type
               when :html
                 "text/html"
               when :json
                 "application/json"
               when :xml
                 "application/xml"
               when :text
                 "text/plain"
               else
                 "text/plain"
               end

      HTTP::Headers{"Accept" => accept}
    end
  end
end
