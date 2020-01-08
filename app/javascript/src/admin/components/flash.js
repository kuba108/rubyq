import { Notyf } from 'notyf';
import 'notyf/notyf.min.css'; // for React and Vue

const Flash = {

  success: function (msg) {
    // Create an instance of Notyf
    var notyf = new Notyf({
      delay: 5000,
      alertIcon: 'fa fa-exclamation-circle',
      confirmIcon: 'fa fa-check-circle'
    });

    // Display an alert notification
    notyf.success(msg);
  },

  error: function (msg) {
    // Create an instance of Notyf
    var notyf = new Notyf({
      delay: 10000,
      alertIcon: 'fa fa-exclamation-circle',
      confirmIcon: 'fa fa-check-circle'
    });

    // Display an alert notification
    notyf.error(msg);
  }

};

export default Flash;