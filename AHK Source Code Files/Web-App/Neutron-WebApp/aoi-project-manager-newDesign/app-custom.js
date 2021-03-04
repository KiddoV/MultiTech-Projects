/*===========================================================================*/
////////////////////////////// Main Functions  ////////////////////////////////
//Functions to run when Page is READY//
$(document).ready(function() {
  //Global Variables  /////////////////
  /////////////////////////////////////
  var recipiesObj = {recipies: []};
  /////////////////////////////////////
  /*** Event for nav bar menu ***/
  if ($(".menu-item").hasClass("active")) {
    let whichTab = $(this).attr("data-toggle");
    //activate tab
    $.tab('change tab', whichTab);
  }

  // Events for app settings Tabs
  $(".app-settings-tabs .item").tab();

  // For search result Container
  var recipeSearchResultContainer_OSIns = $("#recipe-search-result-container").overlayScrollbars({
    className: "os-theme-minimal-dark",
    scrollbars : {
      autoHide: "move",
    },
    overflowBehavior : {
      x : "hidden",
      y : "scroll"
    }
  }).overlayScrollbars();
}); ///////////////////////////////////
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
        ///Init Overlay Scrollbar
        scrollbarIns = $(".app-settings-content").overlayScrollbars({
          className: "os-theme-block-dark",
          scrollbars : {
            autoHide: "move",
          },
          overflowBehavior : {
            x : "hidden",
            y : "scroll"
          }
        }).overlayScrollbars();
      },
      onHidden: function() {
        scrollbarIns.destroy();
      },
    }).modal("toggle set active");
  });
});
/*===========================================================================*/
//////////////////////////////// AngularJS  ///////////////////////////////////
//Function used to get scope outside AngularJS
function getAngularScope(ctrlName) {
    var sel = '[ng-controller="' + ctrlName + '"]';
    return angular.element(sel).scope();
}
///Init AngularJS
var ngApp = angular.module("APM-App", []);
ngApp.controller("APM-App-Controller", function($scope) {
  $scope.recipies = [];
  var json = [{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"},{"name":"John", "age":31, "city":"New York"}];
  //When user hit enter on search field
  $scope.recipeSearch = function() {
    searchVar = document.getElementById("recipe-search-field").value
    //$scope.recipies = ahk.SearchRecipe(searchVar);
    $scope.recipies = json;
    // if ($("#recipe-search .results").is("visible)")) {
    //     ahk.SearchRecipe(searchVar);
    // }
  };
});
