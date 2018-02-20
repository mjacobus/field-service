
const hasKey = (key, object) => {
  return Object.keys(object).indexOf(key) >= 0;
};

const renameProperty = (source, target, object) => {
  if (source == target) {
    return object;
  }

  const newObject = Object.assign({}, object);

  if (hasKey(source, object)) {
    newObject[target] = object[source];
    delete newObject[source];
  }

  return newObject;
};

const renameProperties = (object, properties) => {
  Object.keys(properties).forEach((key) => {
    object = renameProperty(key, properties[key], object);
  });

  return object;
};

const snakeToCamel = (object) => {
  Object.keys(object).forEach((originalKey) => {
    if (originalKey.toString() !== originalKey || originalKey.length < 2) {
      return;
    }

    let camel = originalKey.split('_').map((word, index) => {
      word = word.toString();

      if (index === 0) {
        return word.charAt(0).toLowerCase() + word.slice(1);
      }

      return word.charAt(0).toUpperCase() + word.slice(1);
    }).join('');

    object = renameProperty(originalKey, camel, object);
  });

  return object;
};

export default {
  hasKey,
  snakeToCamel,
  renameProperties,
  renameProperty
}
