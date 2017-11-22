import comparator from '../../utils/comparator'

describe('comparator', () => {
  const values = (newValues = {}) => {
    const defaultValues = { foo: 'fooValue', bar: 'barValue' };
    return Object.assign({}, defaultValues, newValues);
  };

  describe('comparator.hash.equal(A, B)', () => {
    const equal = comparator.hash.equal;
    let a, b;

    beforeEach(() => {
      a = null;
      b = null;
    });

    it('returns true when all A and B are equal', () => {
      a = values();
      b = values();

      expect(equal(a, b)).toBeTruthy();
    });

    it('returns false when one value is different', () => {
      a = values();
      b = values({ foo: 'other' });

      expect(equal(a, b)).toBeFalsy();
    });

    it('returns false when A has one more key', () => {
      a = values({ other: undefined });
      b = values();

      expect(equal(a, b)).toBeFalsy();

      a = values({ other: null })
      expect(equal(a, b)).toBeFalsy();
    });

    it('returns false when B has one more key', () => {
      a = values();
      b = values({ other: undefined });

      expect(equal(a, b)).toBeFalsy();

      b = values({ other: null });
      expect(equal(a, b)).toBeFalsy();
    });

    it('returns true when A and B has same "only" properties and values', () => {
      a = values({ someOther: 'theOther' });
      b = values({ other: 'another' });

      expect(equal(a, b, { only: ['foo', 'bar']})).toBeTruthy();
    });
  });
});
