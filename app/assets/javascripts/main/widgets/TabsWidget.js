function TabsWidget($widget, { callbacks: { CALLBACK_CHANGE_TAB } }) {
  $widget.on('click', '%{w-Tabs/nav/item}', goToTab);

  function goToTab(e) {
    let $item   = $(e.currentTarget);
    let tabName = $item.data('tab');

    $widget
      .find('%{w-Tabs/item}, %{w-Tabs/nav/item}')
      .removeClass('is-active')
      .filter(`[data-tab="${tabName}"]`)
      .addClass('is-active');

    CALLBACK_CHANGE_TAB(tabName);
  }
}

export default TabsWidget;