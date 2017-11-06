import React from 'react';
import { NavLink } from 'react-router-dom';

function Sidebar() {
  return (
    <div id="sidebar">
      <div className="sidebar-header">
        <h3>Hospital</h3>
      </div>
      <ul className="list-unstyled components">
        <li className="active">
          <NavLink to="/">Home</NavLink>
        </li>
        <li>
          <NavLink to="/">Home</NavLink>
        </li>
        <li>
          <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false">
            Page
          </a>
          <ul className="collapse list-unstyled" id="homeSubmenu">
            <li>
              <NavLink to="/">Home</NavLink>
            </li>
            <li>
              <NavLink to="/">Home</NavLink>
            </li>
            <li>
              <NavLink to="/">Home</NavLink>
            </li>
          </ul>
        </li>
        <li>
          <NavLink to="/">Home</NavLink>
        </li>
        <li>
          <NavLink to="/">Home</NavLink>
        </li>
      </ul>
      <div className="row">
        <div className="col-sm-12">
          <p style={{ color: '#fff' }}>Asimisoft Pvt. Ltd.</p>
        </div>
      </div>
    </div>
  );
}

export default Sidebar;
