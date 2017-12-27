
const hasKey = (key, object) => {
  return Object.keys(object).indexOf(key) >= 0;
};

const renameProperty = (source, target, object) => {
  const newObject = Object.assign({}, object);

  if (hasKey(source, object)) {
    newObject[target] = object[source];
    delete newObject[source];
  }

  return newObject;
};

export default {
  hasKey,
  renameProperty
}

