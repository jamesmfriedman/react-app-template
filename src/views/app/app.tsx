import React from 'react';
import { hot } from 'react-hot-loader/root';

import './app.css';

export const App = hot(function App() {
  return (
    <div className="App">
      <header className="App-header">
        <div className="App-logo">
          <span role="img" aria-label="Rocketman">
            🚀
          </span>
        </div>
        <p>Ready?</p>
      </header>
    </div>
  );
});
