import React, { Component } from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

// Bootstrap
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap/dist/css/bootstrap-theme.css';

// components
import { NavigationBar, NotFound } from './components/Pages';
import { Dashboard } from './containers/Dashboards';
import { NewEntryPage } from './containers/Entries';
import { ChartOfAccountPage } from './containers/Settings';

export default function App() {
  const supportsHistory = 'pushState' in window.history;

  return (
    <Router forceRefresh={!supportsHistory}>
      <div>
        <NavigationBar />

        <div className="container">
          <Switch>
            {/* Root path */}
            <Route exact path="/" component={Dashboard} />

            {/* Journal Entries path */}
            <Route path="/entries/new" component={NewEntryPage} />
            <Route
              path="/settings/account-heads"
              component={ChartOfAccountPage}
            />

            {/* 404 Not found */}
            <Route component={NotFound} />
          </Switch>
        </div>
      </div>
    </Router>
  );
}
