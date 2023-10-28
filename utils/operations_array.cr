require "json"
require "ecr"

alias Operations = Array(Operation)

class Operation
  include JSON::Serializable

  property name : String

  property url : String

  property fields : Array(FieldElement)
end

class FieldElement
  include JSON::Serializable

  property name : String

  property field : String
end

operations = Operations.from_json(File.read("#{__DIR__}/operations.json"))

class OperationsArray
  @operations : Operations

  def initialize(operations)
    @operations = operations
  end

  ECR.def_to_s "#{__DIR__}/operations.ecr"
end

print OperationsArray.new(operations).to_s
