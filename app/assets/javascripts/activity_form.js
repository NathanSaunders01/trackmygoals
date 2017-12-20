$(document).on("click", ".btn-submit", function(){
  var id = $(this).attr("id");
   $('#create_activity_form_'+id)
    
    .bind("ajax:beforeSend", function(evt, xhr, settings){
      var $submitButton = $(this).find('button[name="button"]');
      
      $submitButton.replaceWith("<div class='loader'></div>");

    })
    .bind("ajax:success", function(evt, data, status, xhr){
      var $form = $(this);

      $form.find('input[type="number"]').val("");
      
      $('.activity-list').find("h4#no_activities").hide();
      $('.activity-list').prepend(xhr.responseText);
    })
    .bind('ajax:complete', function(evt, xhr, status){
      var $submitLoader = $(this).find('.loader');
      
      setTimeout(function() {
        $submitLoader.replaceWith("<button name='button' type='submit' class='btn btn-primary btn-submit'><i class='fa fa-check'></i></button>");
        $("#ongo_goal_list").load(" #ongo_goal_list");
      }, 1000);
     
    })
    .bind("ajax:error", function(evt, xhr, status, error){
      var $form = $(this),
          errors,
          errorText;

      try {
        // Populate errorText with the comment errors
        errors = $.parseJSON(xhr.responseText);
      } catch(err) {
        // If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
        errors = {message: "Please reload the page and try again"};
      }

      // Build an unordered list from the list of errors
      errorText = "There were errors with the submission: \n<ul>";

      for ( error in errors ) {
        errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
      }

      errorText += "</ul>";

      // Insert error list into form
      $form.find('div.validation-error').html(errorText);
    });

});