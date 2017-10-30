import cast from './cast.js';

export default function format(value, format = 'ru-RU') {
  return cast(value).toLocaleString(format);
};