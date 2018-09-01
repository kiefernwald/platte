require 'mustache'
require 'htmlbeautifier'
require './lib/platte_module'

# Combinator class
class Combinator
  INDENTATION = '    '

  # Combines the given platte modules
  def combine(main, modules, beautify: true)
    html = Mustache.render(
      main.template,
      :module_contents => generate_body(modules),
      :stylesheets => generate_stylesheets(modules)
    )

    html = HtmlBeautifier.beautify(html, indent: INDENTATION) if beautify

    html
  end

  protected

  def generate_body(platte_modules)
    body = ''
    platte_modules.each { |mod| body += "#{mod.template}" }

    body
  end

  def generate_stylesheets(platte_modules)
    styles = Array.new
    platte_modules.each { |mod| styles.concat(mod.stylesheets) }

    styles.uniq
  end
end
