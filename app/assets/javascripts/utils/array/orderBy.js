export default function(items, key) {
  return items.reduce((resultItems, item) => {
    return { ...resultItems, [item[key]]: item };
  }, {});
}
