$(document).on('shown.bs.modal', '.modal', function() {
  $(this).find('[autofocus]').focus();
});
$(document).ready(function() {
  $("#user-modal").on("shown.bs.modal", function () {
    $("#signup-box").validate({
      rules: {
        "user[first_name]": {
          required: true
        },
        "user[last_name]": {
          required: true
        },
        "user[email]": {
          required: true,
        },
        "user[password]": {
          required: true,
          minlength: 6              
        },
        "user[password_confirmation]": {
          required: true,
          minlength: 6
        }
      },
    });
    $("#login-box").validate({
      rules: {
        "user[email]": {
          required: true,
        },
        "user[password]": {
          required: true,
          minlength: 6              
        }
      },
    });
  });
 $("#myNewTodoGoal").on("shown.bs.modal", function () {
    $("#addTodoTaskForm").validate({
       rules: {
            "goal[name]": {
              required: true
            },
            "goal[xp_value]": {
              required: true,
              range: [1, 10000]
            },
        messages: {
            "goal[name]": {
              required: "Name is a required field."
            },
            "goal[xp_value]": {
              required: "XP goal is a required field. Choose a value between 1 and 10,000."
            }
          }
     }
   });
 });
 
 $("div[id^='myUpdateGoal_']").on("shown.bs.modal", function () {
    var modal = $(this);
    modal.children("form#edit_todo_task_form").validate({
         rules: {
              "goal[name]": {
                required: true
              },
              "goal[xp_value]": {
                required: true,
                range: [1, 10000]
              },
          messages: {
              "goal[name]": {
                required: "Name is a required field."
              },
              "goal[xp_value]": {
                required: "XP value is a required field. Choose a value between 1 and 10,000."
              }
            }
       }
     });
     modal.children("form#edit_ongo_task_form").validate({
       rules: {
              "goal[name]": {
                required: true
              },
              "goal[xp_value]": {
                required: true,
                range: [1, 10000]
              },
              "goal[frequency]": {
                required: true
              },
          messages: {
            "goal[name]": {
                required: "Name is a required field."
              },
              "goal[xp_value]": {
                required: "XP value is a required field. Choose a value between 1 and 10,000."
              },
              "goal[frequency]": {
                required: "Frequency is a required field."
              }
            }
       }
     });
  });
  $("div[id^='myUpdateReward_']").on("shown.bs.modal", function () {
    var modal = $(this);
    modal.closest("form").validate({
      rules: {
              "reward[name]": {
                required: true
              },
              "reward[xp_goal]": {
                required: true,
                range: [1, 1000000]
              },
          messages: {
            "reward[name]": {
                required: "Name is a required field."
              },
              "reward[xp_goal]": {
                required: "XP goal is a required field. Choose a value between 1 and 1,000,000."
              },
            }
       }
    });
  });
  $("#myFeedbackModal").on("shown.bs.modal", function () {
    $("#new_contact").validate({
      rules: {
              "contact[comments]": {
                required: true
              },
          messages: {
            "contact[comments]": {
                required: "This field can't be blank."
              }
          }
      }
    });
  });
});
$(document).ready(function() {
  
});