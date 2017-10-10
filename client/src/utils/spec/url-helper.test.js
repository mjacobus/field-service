import UrlHelper from '../url-helper'

describe('UrlHelper', () => {
  const helper = UrlHelper

  describe('.create', () => {
    it('creates url without params', () => {
      expect(helper.create('/foo/bar')).toEqual('/foo/bar')
    });

    it('creates url with empty params', () => {
      expect(helper.create('/foo/bar', {})).toEqual('/foo/bar')
    });

    it('creates an url with query params', () => {
      const url = helper.create('/foo/bar', { foo: 'bar', bar: 'baz' });

      expect(url).toEqual('/foo/bar?bar=baz&foo=bar')
    });

    it('handles array params', () => {
      const url = helper.create('/foo/bar', { foo: [1, 2] });

      expect(url).toEqual('/foo/bar?foo[]=1&foo[]=2')
    });
  });
});
