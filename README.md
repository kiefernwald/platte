# Platte

[![Build Status](https://travis-ci.org/kiefernwald/platte.svg?branch=master)](https://travis-ci.org/kiefernwald/platte)
[![Coverage Status](https://coveralls.io/repos/github/kiefernwald/platte/badge.svg?branch=specs)](https://coveralls.io/github/kiefernwald/platte?branch=specs)

![Plattenbau](pic.jpg)

*(Transport of Plattenbau parts in Karl-Marx-Stadt, GDR, 1975 [CC BY-SA 3.0 de](https://creativecommons.org/licenses/by-sa/3.0/de/deed.en) Deutsche Fotothek)*

Platte is a small command line tool that combines static HTML pages from modules. It is named after the german word [Plattenbau](https://en.wikipedia.org/wiki/Plattenbau) which is a way of building houses based on pre-fabricated parts.

![Plattenbau](output.png)

## Installation

Platte requires a ruby environment with version 2.3 or higher. To install, run:

`gem install platte`

## Usage

After the gem installation, `platte` is available in command line. It lets you combine a static HTML file from a given set of modules. Modules are folders with some configuation files and code in it and sit in the `modules` subfolder of the tool. They come in two flavours:

1. Main modules names, ending with `.main` – usually they hold the surrounding HTML structure with placeholders for resources
2. Other modules names end with `.module` – they are building blocks you can freely combine together as the body of a main module 

You can use the `platte` command as follows:

### list

`platte list`

This call shows you which modules are available in your system.

### combine

`platte combine <TARGET FILE> <MAIN MODULE> <MODULE 1> ... <MODULE N>`

This lets you combine a single main-module with any number of other modules to a given target file.

Example call:

`platte combine some/output/file.html html5 header content`

## Module structure

TODO More docs

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kiefernwald/platte.
