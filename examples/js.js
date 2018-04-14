import configureMockStore from "redux-mock-store";
import thunk from "redux-thunk";
import fetchMock from "fetch-mock";
import queryString from "query-string";

const middlewares = [thunk];
const mockStore = configureMockStore(middlewares);

import * as actions from "../a-registration-email-layer";

import {
  EMAIL_REGISTRATION_SUCCESS,
  EMAIL_REGISTRATION_ERROR
} from "../a-registration-email-layer";

import { API_BASE } from "../../config";

describe("performUserRegistration", () => {
  let responseBody;
  let responseStatus;

  afterEach(() => {
    fetchMock.reset();
    fetchMock.restore();
    responseBody = null;
    responseStatus = null;
  });

  const performRequest = callback => {
    const store = mockStore({});
    const registration = {
      first_name: "_FIRSTNAME",
      last_name: "_LASTNAME",
      email: "_EMAIL",
      password: "_PASSWORD"
    };
    const captcha = "_CAPTCHA";
    const url = `${API_BASE}registrations`;
    const locale = "_LOCALE";

    const body = { locale, registration, captcha };
    const mockResponse = { body: responseBody, status: responseStatus };
    fetchMock.postOnce(url, mockResponse, body);
    store
      .dispatch(actions.performUserRegistration(registration, captcha))
      .then(() => {
        callback(store);
      });
  };

  describe("on a successful request", () => {
    beforeEach(() => {
      responseBody = { redirectTo: "REDIRECT" };
      responseStatus = 200;
    });

    it("creates EMAIL_REGISTRATION_SUCCESS for email registration", () => {
      const expectedActions = [
        {
          type: EMAIL_REGISTRATION_SUCCESS,
          response: "REDIRECT"
        }
      ];

      performRequest(store =>
        expect(store.getActions()).toEqual(expectedActions)
      );
    });
  });

  describe("when there are validation errors", () => {
    beforeEach(() => {
      responseBody = {
        errors: [
          {
            field: "first_name",
            message: "_FIRST_NAME_ERROR"
          },
          {
            field: "last_name",
            message: "_LAST_NAME_ERROR"
          },
          {
            field: "email",
            message: "_EMAIL_ERROR"
          }
        ]
      };

      responseStatus = 400;
    });

    it("creates EMAIL_REGISTRATION_ERROR for email registration", () => {
      const expectedActions = [
        {
          type: EMAIL_REGISTRATION_ERROR,
          errors: responseBody
        }
      ];

      performRequest(store =>
        expect(store.getActions()).toEqual(expectedActions)
      );
    });
  });
});



// @flow

import { fetchJson } from "malt-network";
import { API_BASE, BASE_URL } from "../config";
import selectLocale from "../selectors/s-locale";
import { type DispatchAPI } from "redux"; // eslint-disable-line
import type { CampusState } from "../main";

export const EMAIL_REGISTRATION_SUCCESS = "EMAIL_REGISTRATION_SUCCESS";
export const EMAIL_REGISTRATION_ERROR = "EMAIL_REGISTRATION_ERROR";
export const EMAIL_REGISTRATION_CLEAR_ERROR_FIELDS =
  "EMAIL_REGISTRATION_CLEAR_ERROR_FIELDS";

// TODO: Do we use it? Should we create one for error as well?
export type ActionEmailRegistrationResponse = {
  type: "EMAIL_REGISTRATION_SUCCESS",
  emailRegistrationData: any
};

export const clearRegistrationErrorsFields = () => {
  return {
    type: EMAIL_REGISTRATION_CLEAR_ERROR_FIELDS
  };
};

export const performUserRegistration = (
  userInfo: any = {},
  captcha: string = ""
) => {
  return async (dispatch: DispatchAPI<*>, getState: () => CampusState) => {
    const locale = selectLocale(getState());
    userInfo.redirect = window.location.href;
    await fetchJson(`${API_BASE}registrations`, {
      headers: {
        "Content-Type": "application/json; charset=UTF-8"
      },
      method: "POST",
      body: JSON.stringify({
        captcha: captcha,
        registration: userInfo,
        locale: locale
      })
    })
      .then(resultJson => {
        dispatch(setRegistrationSuccess(resultJson));
      })
      .catch(error => {
        if (error.jsonResponse)
          dispatch(setRegistrationError(error.jsonResponse));
        return Promise.resolve();
      });
  };
};

const setRegistrationSuccess = response => {
  return {
    type: EMAIL_REGISTRATION_SUCCESS,
    response: response.redirectTo
  };
};

const setRegistrationError = response => {
  return {
    type: EMAIL_REGISTRATION_ERROR,
    errors: response
  };
};



const fetchJson = (url, options = {}) => {
  const { maxAge = 0, method } = options;

  options = Object.assign({}, DEFAULT_OPTIONS, options);

  // cache is only filled
  const cachedValue = hitCache(url, maxAge);
  if (cachedValue) {
    return cachedValue;
  }

  const promise = fetchWithCsrf(getUrl(url), options).then(res => {
    if (res.status === 204) {
      return null;
    }
    return res
      .json()
      .then(json => {
        if (res.ok) {
          return json;
        } else {
          return Promise.reject(
            new ResponseError(
              `Server responded with status ${res.status} ${res.statusText}`,
              res,
              json
            )
          );
        }
      })
      .catch(e => {
        let error;
        if (e instanceof ResponseError) {
          error = e;
        } else {
          error = new ResponseError(e, res);
        }
        return Promise.reject(error);
      });
  });

  // only GET requests are cached
  if (!method || method === 'GET') {
    addToCache(url, promise, maxAge);
  }
  return promise;
};

// initial fill
fillCache(global.API_CACHE);

// internal use for unit tests
export { addToCache, fillCache, removeFromCache, resetCache, cache };

export default fetchJson;

function resolveAfter2Seconds() {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve('resolved');
    }, 2000);
  });
}

async function asyncCall() {
  console.log('calling');
  var result = await resolveAfter2Seconds();
  console.log(result);
  // expected output: "resolved"
}

asyncCall();
