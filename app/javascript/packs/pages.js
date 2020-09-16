$(document).ready(function() {
  $("#query-page-button").click(function() {
    // This will update the submit button while the job is being executed, when it is reloaded with text
    $("#query-page-button").html("<span><i class='fa fa-cog fa-spin'></i>&nbsp;Working...</span>"); 
    let url = { url: $('#input-url').val() }
    $.post( "/pages/", url, function(data) {
      $(".result").html(data);
      // Here we execute our polling of the backend with an ajax call and a 3s timeout (in the checkProcessedJob function)
      checkProcessedJob(data['page_id']);
      $("#query-page-button").html("<span></i>Submit</span>"); 
    }); 
  });
});

function checkProcessedJob(page_id) {
  $.ajax({
    url: "/pages/" + page_id,
    error: function(data) {
      // If an error occurs, we only update the url text
      $('#og_url').text("Sorry, no valid Open Graph image URL could be found.");
    },
    success: function(data) {
      // We update the image as detailed on the backend code, with a last resort catch all else clause
      if ( data['processed'] == true && data['og_image_url'] != null ) {
        $('#og_url').text(data['og_image_url']);
      } else {
        $('#og_url').text("Sorry, no valid Open Graph image URL could be found.");
      };
      $("#og_image").attr("src", data['og_image_url']);
    },
    timeout: 3000
  });
}
