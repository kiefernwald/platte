# frozen_string_literal: true

require './lib/combinator'

RSpec.describe 'Combinator#combine' do
  it 'integrates contents from modules into main module' do
    main_module = PlatteModule.new(
      'mm1',
      'MM1',
      'My main mod',
      'This is my <strong>{{{module_contents}}}</strong> module.'
    )

    module_1 = PlatteModule.new(
      'sm1',
      'SM1',
      'My submodule one',
      'super,&nbsp;cool,'
    )

    module_2 = PlatteModule.new(
      'sm2',
      'SM2',
      'My submodule two',
      '&nbsp;<u>awesome</u>'
    )

    output = Combinator.new.combine main_module, [module_1, module_2], beautify: false
    expect(output).to eq('This is my <strong>super,&nbsp;cool,&nbsp;<u>awesome</u></strong> module.')
  end

  it 'integrates stylesheets from modules into main module' do
    main_module = PlatteModule.new(
      'mm1',
      'MM1',
      'My main mod',
      '<html><head>{{#stylesheets}}<link rel="stylesheet" href="{{.}}" />{{/stylesheets}}</head></html>'
    )

    module_1 = PlatteModule.new(
      'sm1',
      'SM1',
      'My submodule one',
      '',
      %w(assets/css/sms1_1.css assets/css/sms1_2.css)
    )

    module_2 = PlatteModule.new(
      'sm2',
      'SM2',
      'My submodule two',
      '',
      %w(assets/css/sms2_1.css assets/css/sms2_2.css)
    )

    output = Combinator.new.combine main_module, [module_1, module_2], beautify: false
    expect(output).to eq('<html><head><link rel="stylesheet" href="assets/css/sms1_1.css" /><link rel="stylesheet" href="assets/css/sms1_2.css" /><link rel="stylesheet" href="assets/css/sms2_1.css" /><link rel="stylesheet" href="assets/css/sms2_2.css" /></head></html>')
  end

  it 'handles repeatedly used modules correctly' do
    main_module = PlatteModule.new(
      'mm1',
      'MM1',
      'My main mod',
      '<html><head>{{#stylesheets}}<link rel="stylesheet" href="{{.}}" />{{/stylesheets}}</head><body>{{{module_contents}}}</body></html>'
    )

    module_1 = PlatteModule.new(
      'hd1',
      'HD1',
      'A heading',
      '<h1>Some text</h1>',
      %w(assets/css/hd1.css assets/css/hd2.css)
    )

    output = Combinator.new.combine main_module, [module_1, module_1], beautify: false
    expect(output).to eq('<html><head><link rel="stylesheet" href="assets/css/hd1.css" /><link rel="stylesheet" href="assets/css/hd2.css" /></head><body><h1>Some text</h1><h1>Some text</h1></body></html>')
  end
end
