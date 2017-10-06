import './../stylesheets/main.bundle.styl';
import './libs/zepto.js';
import './libs/zepto.element.js';

import DOMComponent from './modules/DOMComponent.js';

import 'main/components/DateControl.js';
import 'main/components/TextareaControl.js';

$(() => {
  DOMComponent.live();
});
