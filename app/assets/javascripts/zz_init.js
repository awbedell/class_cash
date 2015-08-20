$(function () {
  'use strict';

  app.periods.togglePeriod();

  if ($('.student-table').length) {

    app.students.displayOptions();
  }

  if ($('.roster-title').length) {
    app.periods.displayPeriodsOptions();
  }

  if ($('.period-table-info').length) {
    app.periods.displayPeriodOptions();
  }

  // input section stuff
  $('.login-input-box').focusin(function() {
    $(this).siblings('span').addClass('focus-in');
  });

  $('.login-input-box').focusout(function() {
    var characters = $(this).val();
    if (characters === '') {
    $(this).siblings('span').removeClass('focus-in');
  }
  });

//Awards Modal
  $('.display-class-bonus-modal').click(function() {
    $('.class-bonus-modal-container').slideDown();
    $('.class-bonus-modal-header').slideDown();
    $('.class-bonus-modal').fadeIn(1000);
    $('.close-btn').fadeIn();
  });

  $('.close-btn').click(function() {
    $(this).parent().parent().slideUp();
    $('.class-bonus-modal-header').slideUp();
    $(this).fadeOut();
    $('.class-bonus-modal').fadeOut('fast');
  });

//Bonus Modal
  $('.display-bonus-modal').click(function() {
    $('.bonus-modal-container').slideDown();
    $('.bonus-modal-header').slideDown();
    $('.bonus-modal').fadeIn(1000);
    $('.close-btn').fadeIn();
  });

  $('.close-btn').click(function() {
    $(this).parent().parent().slideUp();
    $('.bonus-modal-header').slideUp();
    $(this).fadeOut();
    $('.bonus-modal').fadeOut('fast');
  });

//Student Dropdown
  $('.student-transaction-heading').click(function() {
    $(this).next().slideToggle('slow');
    $(this).find('.student-transaction-dropdown').toggleClass('rotate-dropdown');
  });

// Rights
  if ($('.rights-container').length) {
    app.rights.assignRights();
  }

//Default Modal
  $('.view-modal-btn').click(function() {
    $(this).next().fadeIn('slow');
  });

  $('.modal-close').click(function() {
    $('.main-modal-container').fadeOut('slow');
  });

  $('.new-loan-btn').click(function() {
    $('.new-loan-modal').fadeIn('slow');
  });


});
