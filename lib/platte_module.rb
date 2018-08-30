require 'json'

# A single template
class PlatteModule
  def initialize(folder)
    @folder = folder
    initialize_module_info
    initialize_template
  end

  def directory
    File.expand_path "./#{@folder}"
  end

  attr_reader :name
  attr_reader :description
  attr_reader :stylesheets
  attr_reader :javascripts
  attr_reader :template

  protected

  def initialize_module_info
    json_file = File.read("#{@folder}/info.json")
    info = JSON.parse(json_file)

    @name = info['name']
    @description = info['description']
    @stylesheets = info['stylesheets'] if info['stylesheets']
    @javascripts = info['javascripts'] if info['javascripts']
  end

  def initialize_template
    @template = File.read("#{@folder}/template.mustache")
  end
end
