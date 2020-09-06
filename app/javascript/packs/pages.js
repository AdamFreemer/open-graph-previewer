$(document).ready(function() {
  $("#query-page-button").click(function() {
    console.log("click!")
    $("#query-page-button").html("<span><i class='fa fa-cog fa-spin'></i>&nbsp;Working...</span>"); 
  });
});