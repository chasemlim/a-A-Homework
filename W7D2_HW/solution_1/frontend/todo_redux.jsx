import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  const store = applyMiddlewares(store, [addLoggingToDispatch]);
  store.dispatch = addLoggingToDispatch(store);

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});



const applyMiddlewares = (store, list) => {
  let dispatch = store.dispatch;
  list.forEach(middleware => {
    debugger;
    dispatch = middleware(store)(dispatch);
  });
  return Object.assign({}, store, { dispatch });
}