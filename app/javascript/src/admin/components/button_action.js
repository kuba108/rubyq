import Rails from "@rails/ujs";

const ButtonAction = {

  init: function() {
    let sendActors = document.querySelectorAll('[data-action=send-form]');
    Array.prototype.forEach.call(sendActors, function(element) {
      element.addEventListener('click', ButtonAction.clickHandler)
    });
  },

  clickHandler: function(e) {
    let form = document.querySelector(e.target.dataset.form);
    if(form) {
      Rails.fire(form, 'submit')
    }
  }

};

export default ButtonAction;