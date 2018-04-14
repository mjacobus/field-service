import fetchMock from 'fetch-mock'
import mockStore from 'fetch-mock'

import routes from '../../api-routes';
import * as actions from '../../actions/householder-actions';

// import * from '../'

// import configureMockStore from "redux-mock-store";
// import thunk from "redux-thunk";
// import fetchMock from "fetch-mock";
// import queryString from "query-string";
//
// const middlewares = [thunk];
// const mockStore = configureMockStore(middlewares);

describe('createHouseholder', () => {
  it('creates householder with correct payload', () => {
    const territorySlug = 'the-slug';
    const url = routes.householders.create(territorySlug);


    const requestBody = { request: 'ok' };
    const responseBody = { ok: 'ok' };
    const mockResponse = { body: requestBody, status: 200 };

    fetchMock.postOnce(url, mockResponse, responseBody);

    actions.createHouseholder('the-slug', requestBody);
  });
});
