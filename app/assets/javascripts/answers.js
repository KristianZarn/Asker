// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function enablejs_answers() {
    $(document).ready(function() {
        // start with hidden window
        $("#wrapAnswerForm").hide();
        $(".formError").hide();

        // open dialog
        $("#addAnswer").click(function() {
            $("#overlay").css("z-index", "1");
            $("#wrapAnswerForm").slideDown(250);
        }); //end click

        // close dialog
        $("#closeImg, #overlay").click(function() {
            $("#wrapAnswerForm").slideUp(250,
                function() {
                    $("#overlay").css("z-index", "-1");
                });
            $("#answer_content").val("").removeClass("inputBorderRed");
            $("#answer_content").next(".formError").hide();
        }); //end click

        $("#wrapAnswerForm").click(function(evt) {
            evt.stopPropagation();
        }); //end click

        // validate on blur
        $("#answer_content").blur(function() {
            if ($(this).val() == "") {
                $(this).addClass("inputBorderRed");
                $(this).next(".formError").show();
            } else {
                $(this).removeClass("inputBorderRed");
                $(this).next(".formError").hide();
            }
        }); //end blur

        // validate on submit
        $("#answerForm").submit(function() {
            var valid = true;
            var $tmp = $("#answer_content");
            if ($tmp.val() == "") {
                $tmp.addClass("inputBorderRed");
                $tmp.next(".formError").show();
                valid = false;
            }

            if (!valid) {
                return false;
            }
        }); //end submit
    });
}