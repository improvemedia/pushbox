export default function(items, key) {
  return items.reduce((resultItems, item) => {
    resultItems[item[key]] = resultItems[item[key]] || [];
    resultItems[item[key]].push(item);
    return resultItems;
  }, {});
}
