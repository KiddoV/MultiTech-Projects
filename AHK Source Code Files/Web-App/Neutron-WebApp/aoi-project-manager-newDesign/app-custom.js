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

  // Init Overlay Scrollbar
  // $(".scrolling.content").overlayScrollbars({
  //   scrollbars : {
  //     autoHide: "move",
  //   },
  // });
  $(".test").niceScroll({
    cursorcolor: "#424242", // change cursor color in hex
  });
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
  $("#app-settings-btn").on("click", function() {
    $("#app-settings-modal").modal({
      centered: false,
      transition: "slide down",
    }).modal("show");
  });
});
