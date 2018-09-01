# frozen_string_literal: true

require 'mustache'
require 'htmlbeautifier'
require './lib/platte_module'

# Combinator class
class Combinator
  INDENTATION = '    '

  # Combines the given platte modules
  def combine main, modules, beautify: true
    html = Mustache.render(
      main.template,
      module_contents: generate_body(modules),
      stylesheets: generate_stylesheets(modules),
    )

    postprocess(html, beautify: beautify)
  end

  private

  def generate_body platte_modules
    body = ''
    platte_modules.each { |mod| body += mod.template.to_s }

    body
  end

  def generate_stylesheets platte_modules
    styles = []
    platte_modules.each { |mod| styles.concat(mod.stylesheets) }

    styles.uniq
  end

  def postprocess html, beautify: true
    return HtmlBeautifier.beautify(html, indent: INDENTATION) if beautify

    html
  end
end
