$(document).ready(function() {
  $("#query-page-button").click(function() {
    $("#query-page-button").html("<span><i class='fa fa-cog fa-spin'></i>&nbsp;Working...</span>"); 
    let url = { url: encodeURIComponent($('#input-url').val()) }

    $.post( "/pages/", url, function(data) {
      $(".result").html(data);

      checkProcessedJob(data['page_id']);
    }); 
  });
});

function checkProcessedJob(page_id) {
  var jqxhr = $.get( "/pages/" + page_id, function(data) {
    $(".result").html(data);
  })

  jqxhr.always(function(data) {
    console.log("== data['og_image_url']: " + data['og_image_url'])
    console.log("== data['processed']: " + data['processed'])
    $('#og_url').text(`${data['og_image_url']}` );
    $("#og_image").attr("src", data['og_image_url']);
    $("#query-page-button").html("<span></i>Submit</span>"); 
    console.log( "== always callback executed" );
  });
}
