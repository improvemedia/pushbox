import { h } from 'services/VDOM.js';

const NoticeList = ({ store, state }) => {
  return <div class="b-notice-list">
    {state.notices.map(({ type, title, desc, onClose }) => (
      <div class={`b-notice-list_item b-notice-list_item__${type}`} onClick={onClose}>
        <div class="_title">{title}</div>
        <div class="_desc">{desc}</div>
        <div class="_close"></div>
      </div>
    ))}
  </div>
}

export default NoticeList;
