$(document).ready(function() {
    zerocl();

    $(document).on('ajax:success', '#new_maket', function(e, data, textStatus, xhr) {
        var formDiv = $(e.target).closest('.maket_wrapper')
        appendMaket(data.create_status, data.form_html, data.maket_html, formDiv)
        /*location.reload();*/
        zerocl();
    })

    $('.maket_up').click(function () {
        var btn = $(this)
        btn.button('loading')
    })
})


function appendMaket(status, formHTML, maketHTML, formDiv) {
    if (status) {
        var maketDiv = $(maketHTML)
        $(".makets").append(maketDiv)
        maketDiv.hide().fadeIn("slow")
        $('#new_maket', '.maket_wrapper').replaceWith(formHTML)
    }
    else {
        formDiv.replaceWith(formHTML)
    }
}

function zerocl() {
    var client = new ZeroClipboard( $('.copy_text') );

    client.on( 'load', function(client) {
        client.on( 'datarequested', function(client) {
            client.setText(this.href);
        });
        client.on( 'complete', function(client, args) {
          alert("Link copied to clipboard");
        });
    });

    client.on( 'wrongflash noflash', function() {
        ZeroClipboard.destroy();
    });
}