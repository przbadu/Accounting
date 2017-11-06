import React from 'react';
import { Route, Switch } from 'react-router-dom';

// components
import Home from '../screen/Home';
import About from '../components/About';

const Routes = () => (
  <Switch>
    <Route exact path="/" component={Home} />
    <Route path="/about" component={About} />
  </Switch>
);

export default Routes;
