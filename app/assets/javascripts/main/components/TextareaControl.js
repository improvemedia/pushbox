import DOMComponent from 'services/DOMComponent.js';

import FlexibleTextareaWidget from 'main/widgets/FlexibleTextareaWidget.js';

DOMComponent.register('c-TextareaControl', ($block, props = {}) => {
  props = {
    flexible: false,
    ...props
  };

  if (props.flexible) {
    FlexibleTextareaWidget($block.find('%{c-TextareaControl/input}'));
  }
});