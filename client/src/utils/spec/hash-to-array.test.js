import hashToArray from '../hash-to-array';

describe('hashToArray()', () => {
  it('converts a indexed hash to array', () => {
    const hash = {
      0: 'one',
      1: 'two',
    };

    expect(hashToArray(hash)).toEqual(['one', 'two']);
  });
});
