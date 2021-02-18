/*============================================================================*/
////////////////////////////// Main Functions  /////////////////////////////////
//Functions to run when Page is READY
$(document).ready(function() {
  /*** Event for nav bar menu ***/
  if ($(".menu-item").hasClass("active")) {
    let whichTab = $(this).attr("data-toggle");
    //activate tab
    $.tab('change tab', whichTab);
  }


});

$(function() {
  $(".menu-item").on("click", function() {
    let whichTab = $(this).attr("data-toggle");
    $('.menu-item').removeClass('active');
    $(this).addClass('active');

    //activate tab
    $.tab('change tab', whichTab);
  });
});

$(function() {
  var scrollbar
  $("#app-settings-btn").on("click", function() {
    $("#app-settings-modal").modal({
      centered: false,
      transition: "slide down",
      onVisible: function() {
        // Init Overlay Scrollbar
        scrollbar = $(".scrolling.content").overlayScrollbars({
          scrollbars : {
            autoHide: "move",
          },
        }).overlayScrollbars();
      },
      onHidden: function() {
        scrollbar.destroy();
      },
    }).modal("show");
  });
});
