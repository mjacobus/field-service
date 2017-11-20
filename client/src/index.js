import 'whatwg-fetch';
import React from 'react';
import ReactDOM from 'react-dom';
import TerritoryListContainer from './containers/pages/territories/index';
import TerritoryShow from './views/pages/territories/territory-show';
import TopMenu from './views/components/top-menu';
import EnvironmentAlert from './views/components/environment-alert';
import {BrowserRouter, Route} from 'react-router-dom';
import {combineReducers, createStore, compose, applyMiddleware} from 'redux';
import {Provider} from 'react-redux';
import {Grid, Row, Col} from 'react-bootstrap';
import thunk from 'redux-thunk';
import {territoriesReducer} from './reducers/territories';
import routes from './app-routes';
import {IntlProvider} from 'react-intl';
import translations from './translations/pt'

import './index.css';

const reducers = combineReducers(
  {
    territories: territoriesReducer
  }
);

// This is necessary for making the the redux store available on the browser's dev tools pannel
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
let store = createStore(reducers, undefined, composeEnhancers(applyMiddleware(thunk)));

const app = <IntlProvider locale="en" messages={translations}>
  <Provider store={store}>
    <BrowserRouter>
      <div>
        <TopMenu />
        <EnvironmentAlert />
        <Grid>
          <Row>
            <Col xs={12}>
              <div>
                <Route exact path={ routes.territories.index() } component={TerritoryListContainer}/>
                <Route path={ routes.territories.show(':slug') }  component={TerritoryShow}/>
              </div>
            </Col>
          </Row>
        </Grid>
        <div style={ { height: '20px' } }></div>
      </div>
    </BrowserRouter>
  </Provider>
</IntlProvider>;

ReactDOM.render(app, document.getElementById('root'));
