const onlyAttributes = (object, attributes) => {
  const newObject = {};

  attributes.forEach((attribute) => {
    newObject[attribute] = object[attribute];
  });

  return newObject;
};

class Hash {
  /*
   * @param [object] object
   * @param [object] other
   * @param [object] options
   * @option [only] Array with the relevant fields to compare
   */
  static equal(object, other, options = {}) {

    if (options.only) {
      object = onlyAttributes(object, options.only);
      other = onlyAttributes(other, options.only);
    }

    const objectKeys = Object.keys(object);
    const otherKeys = Object.keys(other);

    if (objectKeys.length !== otherKeys.length) {
      return false;
    }

    let differentKeys = objectKeys.filter((key) => {
      if (otherKeys.indexOf(key) < 0) {
        return true;
      }

      if (other[key] !== object[key]) {
        return true
      }

      return false;
    });

    return differentKeys.length === 0;
  }
};

export default {
  hash: Hash
};
