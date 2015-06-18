app.nav = {
  hamburger: function () {
    $('.menu-btn').click(function () {
    $('.menu-responsive').toggleClass('expand');
  });
  },
  
  removeBurger: function () {
    $('.navigation').remove();
  },
  
  showStudent: function () {
    $('.menu-responsive ul').append(
      '<li><a class="home" href="/">Home</a></li>' +
      '<li><a class="back" href="/students">Back</a></li>' +
      '<li><a class="edit" href="' + $(location).attr('pathname') + '/edit">Edit</a></li>'
      );
  },
}