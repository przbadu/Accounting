import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk';
import reducers from '../reducers';

let composeEnhancer;

if (process.env.NODE_ENV === 'development') {
  composeEnhancer = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
} else {
  composeEnhancer = compose;
}

export default function configureStore() {
  return createStore(reducers, composeEnhancer(applyMiddleware(thunk)));
}
