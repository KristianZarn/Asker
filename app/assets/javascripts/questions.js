// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function enablejs_questions() {
    $(document).ready(function() {
        // start with hidden window
        $("#wrapQuestionForm").hide();
        $(".formError").hide();

        // open dialog
        $("#askQuestion").click(function() {
            $("#overlay").css("z-index", "1");
            $("#wrapQuestionForm").slideDown(250);
        }); //end click

        //close dialog
        $("#closeImg, #overlay").click(function() {
            $("#wrapQuestionForm").slideUp(250,
                function() {
                    $("#overlay").css("z-index", "-1");
                });
            $("#formTitle, #formQuestion").val("");
            $("#formTitle, #formQuestion").removeClass("inputBorderRed");
            $("#formTitle, #formQuestion").next(".formError").hide();
        }); //end click

        $("#wrapQuestionForm").click(function(evt) {
            evt.stopPropagation();
        }); //end click

        // validate on blur
        $("#formTitle, #formQuestion").blur(function() {
            if ($(this).val() == "") {
                $(this).addClass("inputBorderRed");
                $(this).next(".formError").show();
            } else {
                $(this).removeClass("inputBorderRed");
                $(this).next(".formError").hide();
            }
        }); //end blur

        // validate on submit
        $("#questionForm").submit(function() {
            var valid = true;
            $("#formTitle, #formQuestion").each(function() {
                if ($(this).val() == "") {
                    $(this).addClass("inputBorderRed");
                    $(this).next(".formError").show();
                    valid = false;
                }
            });

            if (!valid) {
                return false;
            }
        }); //end submit
    });
}
