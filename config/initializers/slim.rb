shortcut       = Slim::Parser.options[:shortcut]
shortcut['$$'] = { attr: 'data-component' }

Slim::Engine.options[:merge_attrs]['data-component'] = ' '
Slim::Engine.set_options pretty: false
Slim::Engine.set_options attr_list_delims: { '('=> ')', '[' => ']'}
