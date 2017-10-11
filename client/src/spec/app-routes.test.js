import api from '../api-routes';
import app from '../app-routes';

describe('api routes', () => {
  // territories
  it('returns the correct url for territories.index()', () => {
    const url = api.territories.list({foo: 'bar'});

    expect(url).toEqual('/api/territories?foo=bar');
  });

  it('returns the correct url for territories.show()', () => {
    const url = api.territories.show('slug', {foo: 'bar'});

    expect(url).toEqual('/api/territories/slug?foo=bar');
  });

  // territories

  it('returns the correct url for publishers.index()', () => {
    const url = api.publishers.list({foo: 'bar'});

    expect(url).toEqual('/api/publishers?foo=bar');
  });
});

describe('app routes', () => {
  // territories
  it('returns the correct url for territories.index()', () => {
    const url = app.territories.list({foo: 'bar'});

    expect(url).toEqual('/app/territories?foo=bar');
  });

  it('returns the correct url for territories.show()', () => {
    const url = api.territories.show('slug', {foo: 'bar'});

    expect(url).toEqual('/api/territories/slug?foo=bar');
  });

  // publishers
  it('returns the correct url for publishers.index()', () => {
    const url = app.publishers.list({foo: 'bar'});

    expect(url).toEqual('/app/publishers?foo=bar');
  });
});
