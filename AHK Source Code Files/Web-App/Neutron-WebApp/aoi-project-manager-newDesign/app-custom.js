/*============================================================================*/
////////////////////////////// Main Functions  /////////////////////////////////
//Functions to run when Page is READY//
$(document).ready(function() {
  /*** Event for nav bar menu ***/
  if ($(".menu-item").hasClass("active")) {
    let whichTab = $(this).attr("data-toggle");
    //activate tab
    $.tab('change tab', whichTab);
  }
});
///////////////////////////////////////
//Global Variables  //////////////////

///////////////////////////////////////
//Main Functions  ////////////////////
//Functions when user hit nav items (Tabs)
$(function() {
  $(".menu-item").on("click", function() {
    let whichTab = $(this).attr("data-toggle");
    $('.menu-item').removeClass('active');
    $(this).addClass('active');

    //activate tab
    $.tab('change tab', whichTab);
  });
});

//////Dropdown Handles
$(function() {
  $("menu .ui.dropdown").dropdown({
    action: function(text, value, element) {
      selectdItem = $(element).attr("data-select");
      ahk.MainMenuHandle(this, selectdItem);  //Call ahk func
    },
    on: "hover",
    duration: 100,
    delay : {
      hide   : 20,
      show   : 20,
      touch  : 20
    }
  });
});

//////MODAL Handles
//Function when user hit app-setting button
$(function() {
  let scrollbarIns
  $("#app-settings-btn").on("click", function() {
    $("#app-settings-modal").modal({  //Init modal
      centered: false,
      transition: "slide down",
      onVisible: function() {
        // Init Overlay Scrollbar
        scrollbarIns = $(".scrolling.content").overlayScrollbars({
          className: "os-theme-block-dark",
          scrollbars : {
            autoHide: "move",
          },
        }).overlayScrollbars();
      },
      onHidden: function() {
        scrollbarIns.destroy();
      },
    }).modal("show");
  });
});
