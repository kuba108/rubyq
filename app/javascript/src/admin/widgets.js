var Widget = {

  init: function() {
    $('.widget-header').on('click', function(e) {
      // Prevents to open widget when click was on remove button.
      if(e.target.classList.contains('widget-header')) {
        let header = $(this);
        let widget = header.parent();
        if(widget.hasClass('open')) {
          widget.removeClass('open');
        }
        else {
          widget.addClass('open');
        }
      }
    });

    $('.widget-save-btn').on('click', function() {
      var btn = $(this);
      var widget = btn.parents('.widget');
      var body = widget.find('.widget-body');
      body.find('form').submit();
    });
  }

};