# frozen_string_literal: true

require 'json'
require 'exception/platte_module_creation_exception'

# A single module
class PlatteModule
  # rubocop:disable Metrics/ParameterLists
  def initialize folder, name, description, template, stylesheets = [], javascripts = []
    @folder = folder
    @name = name
    @template = template
    @description = description
    @stylesheets = stylesheets if stylesheets
    @javascripts = javascripts if javascripts
  end
  # rubocop:enable Metrics/ParameterLists

  def directory
    File.expand_path "./#{@folder}"
  end

  attr_reader :name
  attr_reader :description
  attr_reader :stylesheets
  attr_reader :javascripts
  attr_reader :template
end
