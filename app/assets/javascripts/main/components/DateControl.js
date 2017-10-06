import DOMComponent from 'modules/DOMComponent.js';
import flatpickr from 'flatpickr';

DOMComponent.register('c-DateControl', ($block, props = {}) => {
  flatpickr($block.find('%{c-DateControl/input}')[0], {
    dateFormat: 'd-m-Y'
  });
});