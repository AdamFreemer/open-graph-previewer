$(document).ready(function() {
  $("#query-page-button").click(function() {
    console.log("click!")
    $("#query-page-button").html("<span><i class='fa fa-cog fa-spin'></i>&nbsp;Working...</span>"); 
    let url = { url: encodeURIComponent($('#input-url').val()) }

    updateProcessedJob();

    $.post( "/pages/", url, function(data) {
      $(".result").html(data);
      console.log('== data: ' + data['og_image_url'])
    }); 

    $("#og_image").attr("src", "https://www.apple.com/ac/structured-data/images/open_graph_logo.png?201809210816");

  });
});

function updateProcessedJob() {
  console.log("== background job awaiting...")
}