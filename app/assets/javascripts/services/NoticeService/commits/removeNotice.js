function COMMIT_REMOVE_NOTICE(state, noticeId) {
  return { ...state, notices: state.notices.filter((notice) => notice.id !== noticeId) };
}

export default COMMIT_REMOVE_NOTICE;
