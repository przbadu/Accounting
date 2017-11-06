import React from 'react';
import $ from 'jquery';
import { NavLink } from 'react-router-dom';

function sidebarToggle() {
  $('#sidebar').toggleClass('active');
  $('#sidebarCollapse').toggleClass('active');
}

function Navigation() {
  return (
    <button
      onClick={sidebarToggle}
      type="button"
      id="sidebarCollapse"
      className="navbar-btn"
    >
      <span />
      <span />
      <span />
    </button>
  );
}

export default Navigation;
