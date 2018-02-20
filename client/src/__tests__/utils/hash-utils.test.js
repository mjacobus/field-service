import hash from '../../utils/hash-utils'

describe('hash', () => {
  describe('.renameProperties', () => {
    it('renames properties', () => {
      const input = { foo_bar: 'bar' };
      const expected = { fooBar: 'bar' };

      const output = hash.renameProperties(input, { foo_bar: 'fooBar' })

      expect(output).toEqual(expected);
    });
  });

  describe('.snakeToCamel', () => {
    it('renames properties from snake to camel case', () => {
      const input = { snake_case: 2, foo_bar: "bar", name: 'john'};
      const expected = { snakeCase: 2, fooBar: "bar", name: 'john' };

      const output = hash.snakeToCamel(input);

      expect(output).toEqual(expected);
    });
  });
});
