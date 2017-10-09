import 'whatwg-fetch';
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import TerritoryListContainer from './containers/pages/territories/index';
import {BrowserRouter, Route} from 'react-router-dom';
import {combineReducers, createStore, compose, applyMiddleware} from 'redux';
import {Provider} from 'react-redux';
import thunk from 'redux-thunk';
import {territories} from './reducers/territories';

const reducers = combineReducers({ territories });

// This is necessary for making the the redux store available on the browser's dev tools pannel
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
let store = createStore(reducers, undefined, composeEnhancers(applyMiddleware(thunk)));

const app =  <Provider store={store}>
    <BrowserRouter>
      <Route path="/" component={TerritoryListContainer}/>
    </BrowserRouter>
  </Provider>;

ReactDOM.render(app, document.getElementById('root'));
