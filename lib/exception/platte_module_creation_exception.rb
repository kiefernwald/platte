class PlatteModuleCreationException < StandardError
  def initialize(reason)
    @reason = reason
  end

  attr_reader :reason
end
