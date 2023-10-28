macro generate_source(data)
  {{data}}
end

macro create_source_file
  source = generate_source({{ run("./operations_array.cr").stringify }})
  File.write("./src/foaas_client/operations.cr", source)
end

create_source_file
