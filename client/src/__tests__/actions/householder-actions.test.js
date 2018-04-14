import fetchMock from 'fetch-mock'
import thunk from "redux-thunk";
import configureMockStore from "redux-mock-store";

import routes from '../../api-routes';
import * as actions from '../../actions/householder-actions';

const middlewares = [thunk];
const mockStore = configureMockStore(middlewares);

describe('createHouseholder', () => {
  let store;
  afterEach(() => {
    fetchMock.reset();
    fetchMock.restore();
  });

  it('creates householder with correct payload', () => {
    store = mockStore({});
    const territorySlug = 'the-slug';
    const url = routes.householders.create(territorySlug);

    const requestBody = { request: 'ok' };
    const responseBody = { ok: 'ok' };
    const mockResponse = { body: requestBody, status: 200 };

    fetchMock.postOnce(url, mockResponse, responseBody);

    let expectedActions = { foo: 'bar-expectation-not-met' };

    let action = actions.createHouseholder('the-slug', requestBody)
    store
      .dispatch(action)
      .then(() => {
        console.log('haaaaaaaaaaa');
        expect(store.getActions()).toEqual(expectedActions)
      });

    // expect(true).toBe(false)
  });
});
