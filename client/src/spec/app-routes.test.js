import ApiRoutes from '../api-routes';

describe('ApiRoutes.territories', () => {
  const routes = ApiRoutes;

  it('returns the correct url', () => {
    const url = routes.territories.list({foo: 'bar'});

    expect(url).toEqual('/api/territories?foo=bar');
  });
});
