import DOMComponent from 'services/DOMComponent.js';
import HttpService  from 'services/HttpService.js';

DOMComponent.register('c-RailsItem', ($block, props = {}) => {
  const onDestroy = (e) => {
    const destroyUrl = $(e.currentTarget).attr('href');

    HttpService
      .delete(destroyUrl)
      .then(() => $block.remove());

    e.preventDefault();
  }

  $block.on('click', '%{c-RailsItem/destroy}', onDestroy);
});