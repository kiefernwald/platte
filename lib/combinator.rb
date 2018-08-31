require 'mustache'
require 'htmlbeautifier'
require './lib/platte_module'

# Combinator class
class Combinator
  INDENTATION = '    '

  # Combines the given platte modules
  def combine(main, modules)
    html = Mustache.render(
      main.template,
      :container_body => generate_body(modules),
      :stylesheets => generate_stylesheets(modules)
    )

    HtmlBeautifier.beautify(html, indent: INDENTATION)
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
