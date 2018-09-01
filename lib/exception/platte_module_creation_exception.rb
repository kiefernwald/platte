# frozen_string_literal: true

# Exception thrown during creation of a Platte module
class PlatteModuleCreationException < StandardError
  def initialize reason
    @reason = reason
  end

  attr_reader :reason
end
