import React from 'react';
import { Navbar, Nav, NavItem } from 'react-bootstrap';
import { IndexLinkContainer, LinkContainer } from 'react-router-bootstrap';

function NavigationBar() {
  return (
    <Navbar collapseOnSelect>
      <Navbar.Header>
        <Navbar.Brand>
          <LinkContainer to="/">
            <a>Accounting</a>
          </LinkContainer>
        </Navbar.Brand>
        <Navbar.Toggle />
      </Navbar.Header>
      <Navbar.Collapse>
        <Nav pullRight>
          <IndexLinkContainer to="/dashboards" activeClassName="active">
            <NavItem>Dashboard</NavItem>
          </IndexLinkContainer>
          <IndexLinkContainer to="/entries/new" activeClassName="active">
            <NavItem>Journal Entries</NavItem>
          </IndexLinkContainer>
          <IndexLinkContainer to="/account-heads" activeClassName="active">
            <NavItem>Chart of account</NavItem>
          </IndexLinkContainer>
        </Nav>
      </Navbar.Collapse>
    </Navbar>
  );
}

export default NavigationBar;
