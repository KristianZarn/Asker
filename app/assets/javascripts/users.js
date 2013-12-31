// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function validEmail($tmp) {
    var pos = $tmp.val().search(/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/);
    if (pos === -1) {
        $tmp.addClass("inputBorderRed");
        $tmp.next(".formError").show();
        return false;
    } else {
        $tmp.removeClass("inputBorderRed");
        $tmp.next(".formError").hide();
        return true;
    }
}

function notEmpty($tmp) {
    if ($tmp.val() == "") {
        $tmp.addClass("inputBorderRed");
        $tmp.next(".formError").show();
        return false;
    } else {
        $tmp.removeClass("inputBorderRed");
        $tmp.next(".formError").hide();
        return true;
    }
}

function validNewPass($tmp) {
    if ($tmp.val().length < 6) {
        $tmp.addClass("inputBorderRed");
        $tmp.next(".formError").show();
        return false;
    } else {
        $tmp.removeClass("inputBorderRed");
        $tmp.next(".formError").hide();
        return true;
    }
}

function validConfirmPass($pass1, $pass2) {
    if ( ($pass1.val() !== $pass2.val()) || ($pass1.val() == "") ) {
        $pass1.addClass("inputBorderRed");
        $pass1.next(".formError").show();
        return false;
    } else {
        $pass1.removeClass("inputBorderRed");
        $pass1.next(".formError").hide();
        return true;
    }
}

function isChecked($tmp) {
    if ($tmp.prop("checked")) {
        $tmp.siblings(".formError").hide();
        return true;
    } else {
        $tmp.siblings(".formError").show();
        return false;
    }
}

function enablejs_signin() {
    $(document).ready(function() {

        $(".formError").hide();

        // sign in validate on blur
        $("#email_1").blur(function() {
            validEmail($(this));
        });
        $("#pass_1").blur(function() {
            notEmpty($(this));
        });

        // sign in validate on submit
        $("#signInForm").submit(function() {
            var valid = true;
            valid = validEmail($("#email_1")) && valid;
            valid = notEmpty($("#pass_1")) && valid;

            if (!valid) {
                return false;
            }
        }); //end submit

        // create account validate on blur
        $("#email_2").blur(function() {
            validEmail($(this));
        });
        $("#dispName").blur(function() {
            notEmpty($(this));
        });
        $("#firstName").blur(function() {
            notEmpty($(this));
        });
        $("#lastName").blur(function() {
            notEmpty($(this));
        });
        $("#pass_2").blur(function() {
            validNewPass($(this));
        });
        $("#passConfirm").blur(function() {
            validConfirmPass($(this), $("#pass_2"));
        });
        $("#terms").click(function() {
            isChecked($(this));
        });

        // create account validate on submit
        $("#createAccountForm").submit(function() {
            var valid = true;
            valid = validEmail($("#email_2")) && valid;
            valid = notEmpty($("#dispName")) && valid;
            valid = notEmpty($("#firstName")) && valid;
            valid = notEmpty($("#lastName")) && valid;
            valid = validNewPass($("#pass_2")) && valid;
            valid = validConfirmPass($("#passConfirm"), $("#pass_2")) && valid;
            valid = isChecked($("#terms")) && valid;

            if (!valid) {
                return false;
            }
        });

    }); //end ready
}