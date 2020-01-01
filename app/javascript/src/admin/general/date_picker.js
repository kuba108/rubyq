var DatePicker = {

  init: function() {
    $('.date-range-filter input.start-date').datetimepicker({
      locale: 'cs',
      format: 'YYYY-MM-DD 00:00:00',
      dayViewHeaderFormat: 'MMMM YYYY',
      icons: {
        time: "fa fa-clock-o",
        date: "fa fa-calendar",
        up: "fa fa-arrow-up",
        down: "fa fa-arrow-down",
        next: "fa fa-arrow-right",
        previous: "fa fa-arrow-left",
        clear: "fa fa-trash"
      },
      showClear: true
    });

    $('.date-range-filter input.end-date').datetimepicker({
      locale: 'cs',
      format: 'YYYY-MM-DD 23:59:59',
      dayViewHeaderFormat: 'MMMM YYYY',
      icons: {
        time: "fa fa-clock-o",
        date: "fa fa-calendar",
        up: "fa fa-arrow-up",
        down: "fa fa-arrow-down",
        next: "fa fa-arrow-right",
        previous: "fa fa-arrow-left",
        clear: "fa fa-trash"
      },
      showClear: true
    });

    $('.date-picker').datetimepicker({
      locale: 'cs',
      format: 'YYYY-MM-DD',
      dayViewHeaderFormat: 'MMMM YYYY',
      icons: {
        time: "fa fa-clock-o",
        date: "fa fa-calendar",
        up: "fa fa-arrow-up",
        down: "fa fa-arrow-down",
        next: "fa fa-arrow-right",
        previous: "fa fa-arrow-left"
      }
    });

    $('.time-picker').datetimepicker({
      locale: 'cs',
      format: 'YYYY-MM-DD HH:mm',
      dayViewHeaderFormat: 'MMMM YYYY',
      icons: {
        time: "fa fa-clock-o",
        date: "fa fa-calendar",
        up: "fa fa-arrow-up",
        down: "fa fa-arrow-down",
        next: "fa fa-arrow-right",
        previous: "fa fa-arrow-left"
      }
    });
  }

};