# frozen_string_literal: true

# Loader for Platte modules
class PlatteModuleLoader
  def create_from_folder folder
    raise PlatteModuleCreationException, "Module at #{folder} could not be found!" unless File.exist? folder

    # Extract info
    name, description, stylesheets, javascripts = get_module_info(folder)

    # Read template
    template = File.read("#{folder}/template.mustache")

    PlatteModule.new folder, name, description, template, stylesheets, javascripts
  end

  private

  def get_module_info folder
    info = JSON.parse(File.read("#{folder}/info.json"))
    name = info['name']
    description = info['description']
    stylesheets = info['stylesheets'] || nil
    javascripts = info['javascripts'] || nil

    [name, description, stylesheets, javascripts]
  end
end
