$(document).ready(function() {
  $("#query-page-button").click(function() {
    console.log("click!")
    $("#query-page-button").html("<span><i class='fa fa-cog fa-spin'></i>&nbsp;Working...</span>"); 
    let url = { url: encodeURIComponent($('#input-url').val()) }

    $.post( "/pages/", url, function(data) {
      $(".result").html(data);
      console.log('== data: ' + data['page_being_processed'])
    }); 

    // run this until og_image is populated ever 2s
    updateProcessedJob(data['page_id']);

    $("#og_image").attr("src", "https://www.apple.com/ac/structured-data/images/open_graph_logo.png?201809210816");
  });
});

function checkProcessedJob(page_id) {
  console.log("== background job awaiting...")
  $.get( "/pages/" + page_id, function(data) {
    $(".result").html(data);

    $("#og_image").attr("src", data['og_image_url']);
  }); 
}