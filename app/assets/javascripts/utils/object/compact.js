export default function compact(object) {
  return Object.entries(object)
    .filter(([key, value]) => !!value)
    .reduce((object, [key, value]) => ({ ...object, [key]: value }), {});
}