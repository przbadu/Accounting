import React from 'react';
import ReactDOM from 'react-dom';

import 'bootstrap/dist/css/bootstrap.css';
import './index.css';

import App from './screen/App';
import registerServiceWorker from './registerServiceWorker';

// make bootstrap work with jquery
import jQuery from 'jquery';
window.jQuery = jQuery;
require('bootstrap');

ReactDOM.render(<App />, document.getElementById('root'));
registerServiceWorker();
