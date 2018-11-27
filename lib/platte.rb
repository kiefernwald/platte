# frozen_string_literal: true

require 'thor'
require 'fileutils'
require 'colorize'
require 'combinator'
require 'platte_module_loader'

# Platte command line tool
class Platte < Thor
  desc 'combine FILE MAIN [MODULE [MODULE ...]]', 'combine FILE from MAIN and MODULES.'
  option :no_beautify, type: :boolean, default: false
  def combine file, main, *modules
    main_module, platte_modules = get_modules main, modules
    combine_and_save(file, main_module, platte_modules)
    copy_assets File.dirname(file), main_module, platte_modules
    output_final_info
  rescue PlatteModuleCreationException => e
    output_error e, "Could not load modules to construct #{file}!"
  rescue StandardError => e
    output_error e, "Could not construct #{file}!"
  end

  desc 'list', 'list all available modules.'
  def list
    puts '🏢  The following main modules are available:'.green
    get_modules_from_folder('modules', extension: 'main').each(&method(:output_single_module))
    puts "\n📦  The following modules are available:".green
    get_modules_from_folder('modules').each(&method(:output_single_module))
  end

  private

  def combine_and_save file, main_module, platte_modules
    output_module_info(file, main_module, platte_modules)
    write_to_file file, Combinator.new.combine(main_module, platte_modules, beautify: !options[:no_beautify])
  end

  def output_final_info
    puts 'Done.'.green
    puts '🏢'
  end

  def output_error error, message
    puts message.black.on_red
    puts "  #{error.reason}".red
  end

  def output_module_info file, main_module, platte_modules
    puts "#{'🏗  Constructing'.green} #{file.yellow} #{'from the following modules:'.green}"
    output_single_module(main_module, is_main: true)
    platte_modules.each(&method(:output_single_module))
  end

  def output_single_module module_object, is_main: false
    module_name = is_main ? "#{module_object.name} (main module)" : module_object.name
    puts "  * #{module_name} – #{module_object.description}".blue
  end

  def get_modules_from_folder folder, extension: 'module'
    loader = PlatteModuleLoader.new
    Dir.glob("*.#{extension}", base: folder)
       .map { |mod| loader.create_from_folder "modules/#{mod}" }
  end

  def get_modules main, modules
    puts 'Loading selected modules...'.green
    loader = PlatteModuleLoader.new
    main_module = loader.create_from_folder "modules/#{main}.main"
    platte_modules = modules.map { |mod| loader.create_from_folder "modules/#{mod}.module" }

    [main_module, platte_modules]
  end

  def write_to_file file, contents
    file = File.new(file, 'w')
    file.write(contents)
    file.close
  end

  def copy_assets destination, main, modules
    puts 'Copying assets...'.green
    FileUtils.copy_entry "#{main.directory}/assets", "#{destination}/assets"
    modules&.each { |mod| FileUtils.copy_entry "#{mod.directory}/assets", "#{destination}/assets" }
  end
end
