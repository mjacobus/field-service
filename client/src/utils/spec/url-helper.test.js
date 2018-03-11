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

  describe('.onlyPath', () => {
    const assertOnlyPath = (input, expected) => {
      expect(helper.onlyPath(input)).toEqual(expected);
    };

    it('removes hostname config from url', () => {
      assertOnlyPath('http://localhost:3001/foo/bar', '/foo/bar');
      assertOnlyPath('https://localhost:4000/foo/bar', '/foo/bar');
      assertOnlyPath('http://localhost:4000/foo/bar', '/foo/bar');
      assertOnlyPath('http://localhost/foo/bar', '/foo/bar');
      assertOnlyPath('http://127.1.2.3/foo/bar', '/foo/bar');
      assertOnlyPath('http://dev.fs.com/foo/bar', '/foo/bar');
      assertOnlyPath('/foo/bar', '/foo/bar');
      assertOnlyPath('http://localhost:3001/app/territories/001/edit', '/app/territories/001/edit')
    });
  });
});
