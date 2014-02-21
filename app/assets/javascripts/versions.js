$(document).ready(function() {

    $(document).on('ajax:success', '#new_version', function(e, data, textStatus, xhr) {
    	var formDiv = $(e.target).closest('.version_wrapper')
        appendVersion(data.create_status, data.form_html, data.version_html, formDiv)
    })
})


function appendVersion(status, formHTML, versionHTML, formDiv) {
    if (status) {
        var versionDiv = $(versionHTML)
        $(".versions").append(versionDiv)
        versionDiv.hide().fadeIn("slow")
    	$('#new_version', '.version_wrapper').replaceWith(formHTML)
    }
    else {
    	formDiv.replaceWith(formHTML)
    }
}