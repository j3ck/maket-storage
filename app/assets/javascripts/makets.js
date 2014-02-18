$(document).ready(function() {
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
});