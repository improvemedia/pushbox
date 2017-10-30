import DOMComponent  from 'services/DOMComponent.js';
import HttpService   from 'services/HttpService.js';
import NoticeService from 'services/NoticeService.jsx';

HttpService.defaults = { ...HttpService.defaults,
  headers: {
    'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').getAttribute('content')
  }
}

HttpService.subscribe('afterRequest', ([response, content]) => {
  if (typeof content === 'object') {
    if (content.flash) {
      NoticeService.build(content.flash);
    }

    if (content.redirect_to) {
      window.location.href = content.redirect_to;
    }
  }
});

$(() => {
  DOMComponent.live();
});
