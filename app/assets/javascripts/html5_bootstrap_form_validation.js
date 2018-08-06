$(function(){
  var check_form_validity = function(){
    if ($('form.was-validated :input:invalid').length > 0) {
      $('.actions').addClass('form-errors')
    }else{
      $('.actions').removeClass('form-errors')
    }
  }


  var validate_form_fields = function(event){
    var $form = $(event.target)
    if ($form[0].checkValidity() === false) {
      event.preventDefault(); // prevents form submission
      event.stopPropagation();
    }
    $form.addClass('was-validated');
    check_form_validity();
  }

  $('form :input').on({change: validate_form_fields, keyup: validate_form_fields })
  $('form.needs-validation').on('submit', validate_form_fields);
});
