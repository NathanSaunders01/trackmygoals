$(document).on('shown.bs.modal', '.modal', function() {
  $(this).find('[autofocus]').focus();
  window.dispatchEvent(new Event('resize'));
});
$(document).on("shown.bs.modal", function () {
        $("#addGoalForm").validate({
          rules: {
            "goal[name]": {
              required: true
            },
            "goal[description]": {
              required: true
            },
            "goal[xp_value]": {
              required: true,
              range: [1, 10000]
            },
            "goal[recurrence_id]": {
              required: true
            }
          },
          messages: {
            "goal[name]": {
              required: "Name is a required field."
            },
            "goal[xp_value]": {
              required: "XP value is a required field. Choose a value between 1 and 10,000."
            }
          }
      });
      $("#addRewardForm").validate({
        errorPlacement: function(error, element) {
          if(element.attr("name") == "reward[goal_ids][]") {
            error.insertAfter(".scrollbox");
          } else {
            error.insertAfter(element);
          }
        },
          rules: {
            "reward[name]": {
              required: true
            },
            "reward[xp_goal]": {
              required: true,
              range: [1, 100000]
            },
            "reward[goal_ids][]": {
              required: true,
            }
          },
          messages: {
            "reward[name]": {
              required: "Name is a required field."
            },
            "reward[xp_goal]": {
              required: "XP goal is a required field. Choose a value between 1 and 100,000."
            }
          },
      });
    } );