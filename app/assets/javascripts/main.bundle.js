import './../stylesheets/admin.bundle.styl';
import './libs/zepto.js';
import './libs/zepto.element.js';

import DOMComponent from './modules/DOMComponent.js';

$(function() {
  DOMComponent.live();
});
