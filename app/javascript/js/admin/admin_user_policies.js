export const AdminUserPoliciesIndexView = {

  init: function() {
    $('.check-all').on('change', function() {
      var checkbox = $(this);
      var group_checkboxes = checkbox.parents('.acl-group').find("input:checkbox");
      if(checkbox.is(':checked')) {
        group_checkboxes.each(function() {
          $( this ).prop("checked", true);
        });
      }
      else {
        group_checkboxes.each(function() {
          $( this ).prop("checked", false);
        });
      }
    });
  }

};