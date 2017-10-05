function FlexibleTextareaWidget($el) {
  let offset = $el[0].offsetHeight - $el[0].clientHeight;

  function resize() {
    $el
      .css('height', 'auto')
      .css('height', $el[0].scrollHeight + offset);
  }

  $el.on('keyup input', resize);

  resize();

  return { resize };
}

export default FlexibleTextareaWidget;
