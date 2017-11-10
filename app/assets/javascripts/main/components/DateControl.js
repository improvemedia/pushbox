import DOMComponent from 'services/DOMComponent.js';
import flatpickr from 'flatpickr';

DOMComponent.register('c-DateControl', ($block, props = {}) => {
  flatpickr($block.find('%{c-DateControl/input}')[0], {
    dateFormat: 'd-m-Y h:i',
    enableTime: true,
    minuteIncrement: 10,
    time_24hr: true
  });
});