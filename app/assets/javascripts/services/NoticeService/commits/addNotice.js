function COMMIT_ADD_NOTICE(state, { id, type, title, desc, onClose }) {
  return { ...state, notices: [...state.notices, { id, type, title, desc, onClose }] };
}

export default COMMIT_ADD_NOTICE;
