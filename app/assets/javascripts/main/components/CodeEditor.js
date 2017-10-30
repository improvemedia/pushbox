import DOMComponent from 'services/DOMComponent.js';

// import { edit } from 'brace';
// import 'brace/mode/html';
// import 'brace/theme/solarized_light';

DOMComponent.register('c-CodeEditor', ($block , props = {}) => {
  const editor = edit($block.find('%{c-CodeEditor/textarea}')[0]);

  editor.getSession().setMode('ace/mode/html');
  editor.setTheme('ace/theme/solarized_light');
});