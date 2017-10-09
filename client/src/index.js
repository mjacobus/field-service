import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import TerritoryList from './views/pages/territories/index';
import App from './App';
import registerServiceWorker from './registerServiceWorker';
import {BrowserRouter, Route} from 'react-router-dom';

const app =  <BrowserRouter>
                <Route path="/frontend" component={TerritoryList}/>
             </BrowserRouter>;

ReactDOM.render(app, document.getElementById('root'));
registerServiceWorker();
