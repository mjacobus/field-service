export default (hash) => {
  return Object.keys(hash).map(key => hash[key]);
}
