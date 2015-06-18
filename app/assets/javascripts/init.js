$(function () {
  'use strict';
  
  if ($('.student-table').length) {
    app.students.tableRichest();
  }
  
  if ($('.student-show-container').length) {
    app.students.individualRichest();
  }
  
  if ($('.welcome-container').length || $('.login-container').length) {
    app.nav.removeBurger();
  }
  
  if ($('.student-show-container').length) {
    app.nav.showStudent();
  }
  
  app.nav.hamburger();
  
  
});