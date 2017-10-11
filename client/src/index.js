import 'whatwg-fetch';
import React from 'react';
import ReactDOM from 'react-dom';
import TerritoryListContainer from './containers/pages/territories/list-container';
import TopMenu from './views/components/top-menu';
import EnvironmentAlert from './views/components/environment-alert';
import {BrowserRouter, Route} from 'react-router-dom';
import {combineReducers, createStore, compose, applyMiddleware} from 'redux';
import {Provider} from 'react-redux';
import {Grid, Row, Col} from 'react-bootstrap';
import thunk from 'redux-thunk';
import {territoriesReducer} from './reducers/territories';

import './index.css';

const reducers = combineReducers(
  {
    territories: territoriesReducer
  }
);

// This is necessary for making the the redux store available on the browser's dev tools pannel
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
let store = createStore(reducers, undefined, composeEnhancers(applyMiddleware(thunk)));

const app = <Provider store={store}>
  <div>
    <TopMenu />
    <EnvironmentAlert />
    <Grid>
      <Row>
        <Col xs={12}>
          <BrowserRouter>
            <Route path="/app/territories" component={TerritoryListContainer}/>
          </BrowserRouter>
        </Col>
      </Row>
    </Grid>
  </div>
</Provider>;

ReactDOM.render(app, document.getElementById('root'));
