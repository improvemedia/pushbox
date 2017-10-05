function rewriteSelector(context, name, pos) {
  var original = context[name];

  if (!original) return;

  context[name] = function() {
    arguments[pos] = arguments[pos]
      .replace(/%\{([^\}]+)\}/g, '[data-el~="$1"]');

    return original.apply(context, arguments);
  };

  $.extend(context[name], original);
};

rewriteSelector($.zepto, 'qsa', 1);
rewriteSelector($.zepto, 'matches', 1);
