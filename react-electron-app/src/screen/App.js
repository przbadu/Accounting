import React, { Component } from 'react';
import { HashRouter as Router } from 'react-router-dom';
import { Provider } from 'react-redux';

import Routes from '../config/Routes';
import configureStore from '../config/store';
import { Sidebar, Navigation } from '../components/pages';

const store = configureStore();

function App() {
  return (
    <Provider store={store}>
      <Router>
        <div className="wrapper">
          <Sidebar />

          <div id="content">
            <Navigation />
            <Routes />
          </div>
        </div>
      </Router>
    </Provider>
  );
}

export default App;
