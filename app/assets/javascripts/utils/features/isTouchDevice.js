export default function() {
  return navigator.MaxTouchPoints > 0 || navigator.msMaxTouchPoints > 0 || ('ontouchstart' in window);
}