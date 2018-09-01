require 'json'
require './lib/exception/platte_module_creation_exception'

# A single template
class PlatteModule
  def initialize(folder, name, description, template, stylesheets = [], javascripts = [])
    @folder = folder
    @name = name
    @template = template
    @description = description
    @stylesheets = stylesheets if stylesheets
    @javascripts = javascripts if javascripts
  end

  def directory
    File.expand_path "./#{@folder}"
  end

  attr_reader :name
  attr_reader :description
  attr_reader :stylesheets
  attr_reader :javascripts
  attr_reader :template
end
