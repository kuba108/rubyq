var PagesNewView = {

  init: function() {
    PagesNewView.initPermalink();
  },

  initPermalink: function() {
    $('#page-title').on('input', function() {
      PagesNewView.copy_title_to_permalink(true);
    });

    $('#title-to-permalink-btn').on('click', function() {
      PagesNewView.copy_title_to_permalink();
    });

    $('#enable-permalink-btn').on('click', function() {
      $('#permalink-input').removeAttr('disabled').removeClass('disabled');
      $(this).hide();
      $('#disable-permalink-btn').show();
    });

    $('#disable-permalink-btn').on('click', function() {
      $('#permalink-input').attr('disabled', 'disabled').addClass('disabled');
      $(this).hide();
      $('#enable-permalink-btn').show();
    });

    $('#new-page-form').on('submit', function() {
      $('#permalink-input').removeAttr('disabled').removeClass('disabled');
    });

    // Calls in case, that title has some text by default.
    PagesNewView.copy_title_to_permalink(true);
  },

  // Copies title to permalink and removes all diacritics and spaces.
  // Variable check_lock determines if attribute disabled should be check or should be ignored.
  copy_title_to_permalink: function(check_lock) {
    if(typeof check_lock === 'undefined') {
      check_lock = false
    }

    var permalink = $('#permalink-input');
    var title = $('#page-title');

    if(!check_lock || permalink.hasClass('disabled')) {
      permalink.val(title.val().latinize().makePermalink());
    }
  }

};