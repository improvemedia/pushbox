import { render as VDOMRender, h, VDOMComponent } from 'services/VDOM.js';

import generateId from 'utils/function/generateId.js';

import StoreService from 'services/StoreService.js';

import NoticeList from './NoticeService/components/NoticeList.jsx';

import COMMIT_ADD_NOTICE    from './NoticeService/commits/addNotice.js';
import COMMIT_REMOVE_NOTICE from './NoticeService/commits/removeNotice.js';
import COMMIT_CLEAR_NOTITES from './NoticeService/commits/clearNotices.js';

const NOTICE_TIMEOUT = 5000;

const NoticeService = (() => {
  // Store

  const __store = StoreService({
    props: {
      initialState: {
        notices: []
      }
    }
  });

  __store.on('afterCommit', () => render());

  // Actions

  const addNotice = ({ type, title, desc, timeout }) => {
    const notice = {
      id: generateId(),
      title,
      desc,
      type,
      onClose: () => removeNotice(notice.id)
    }

    __store.commit(COMMIT_ADD_NOTICE, notice);

    setTimeout(() => removeNotice(notice.id), timeout);
  }

  const removeNotice = (noticeId) => {
    __store.commit(COMMIT_REMOVE_NOTICE, noticeId);
  }

  const clearNotices = () => {
    __store.commit(COMMIT_CLEAR_NOTITES);
  }

  // Render

  const render = ((el = null) => () => {
    el = VDOMRender(
      <NoticeList store={__store} state={__store.getState()}/>
    , document.body, el);
  })();

  // Public API

  function error(desc, title = 'Ошибка') {
    addNotice({ type: 'error', title, desc, timeout: NOTICE_TIMEOUT });
  }

  function info(desc, title = '') {
    addNotice({ type: 'info', title, desc, timeout: NOTICE_TIMEOUT });
  }

  function warning(desc, title = '') {
    addNotice({ type: 'warning', title, desc, timeout: NOTICE_TIMEOUT });
  }

  function clear() {
    clearNotices();
  }

  function build(options) {
    const type = ['error', 'notice', 'warning'].find((type) => options[type]);

    ({
      error:   error,
      notice:  info,
      warning: warning
    })[type](options[type]);
  }

  return { error, info, warning, clear, build };
})();

window.NoticeService = NoticeService;

export default NoticeService;
