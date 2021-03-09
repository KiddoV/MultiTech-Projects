/*===========================================================================*/
////////////////////////////// Main Functions  ////////////////////////////////
//Functions to run when Page is READY//
$(document).ready(function() {
  //Global Variables  /////////////////
  /////////////////////////////////////
  app = new AppViewModel();
  ko.applyBindings(app);

  // For search result Container
  // window.recipeSearchResultContainer_OSIns = $("#recipe-search-result-container").overlayScrollbars({
  //   className: "os-theme-minimal-dark",
  //   scrollbars : {
  //     autoHide: "move",
  //   },
  //   overflowBehavior : {
  //     x : "hidden",
  //     y : "scroll"
  //   }
  // }).overlayScrollbars();
  window.recipeLabelsContainer_OSIns = $("#recipe-labels-container").overlayScrollbars({
    className: "os-theme-thin-dark",
    overflowBehavior : {
      x : "scroll",
      y : "hidden"
    }
  }).overlayScrollbars();

  window.recipeActiveViewNotes_OSIns = $("#active-view-recipe-notes").overlayScrollbars({
    className: "os-theme-thin-dark",
    overflowBehavior : {
      x : "hidden",
      y : "scroll"
    }
  }).overlayScrollbars();
  /////////////////////////////////////
  /*** Event for nav bar menu ***/
  if ($(".menu-item").hasClass("active")) {
    let whichTab = $(this).attr("data-toggle");
    //activate tab
    $.tab('change tab', whichTab);
  }

  // Events for app settings Tabs
  $(".app-settings-tabs .item").tab();

  $("#active-view-recipe-tab-nav .item").tab();

  $(".recipe-card").transition('fly down');

}); ///////////////////////////////////
///////////////////////////////////////
//Main Functions  ////////////////////
function recipeSearch() {
  var searchVar = $("#recipe-search-field").val();
  // window.recipeSearchResultContainer_OSIns.sleep();
  returnJson = ahk.GetRecipesBySearch(searchVar);  ///Call func from AHK
  if (searchVar == null) {
    $("#recipe-search .input").removeClass("loading");
    return
  } else {
    app.recipies([]);
    returnArrObj = JSON.parse(returnJson);
    for (let i = 0; i < returnArrObj.length; i++) {
        app.recipies.push(returnArrObj[i]);
    }
    $("#recipe-search .input").removeClass("loading");
  }
}

function getRecipeInfo(data, element) {
  // app.recipies()[0].isPined = 1;
  app.recipeInView(data);
  if ($.grep(app.recipeLabels(), function(item) { return JSON.stringify(item) === JSON.stringify(data);}).length === 0) {
    app.recipeLabels.push(data);
    window.recipeLabelsContainer_OSIns.scroll({ x: "0%"  });
  } else {
    // app.recipeLabels.replace(function(item){return item.prog_full_name = "Viet Ho"});
    $(element).transition("shake");
  }
}

function showRecipeInfo(data, element) {
  app.recipeInView(data);
}
function closeRecipeInfo(data) {
  app.recipeLabels.remove( function(item) {
    return item === data;
  });
}
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
//////////////////////////////// KnockOutJs //////////////////////////////////
function AppViewModel() {
  ///Init variables
  this.recipies = ko.observableArray([]);
  this.recipeLabels = ko.observableArray([]);
  this.recipeInView = ko.observable({})
  // Input variables
  // self.searchText = ko.observable("");

  /////////////////////////////////////
  // Init Functions
  this.showRecipeCard = function(element) {
    if (element.nodeType === 1) {
      $(element).transition({
        animation: "fly down in",
      });
    }
  };
  // this.hideRecipeCard = function(element) {
  //   if (element.nodeType === 1) {
  //     $(element).transition({
  //       animation: "fade out",
  //       onHide: function() {
  //           $(element).remove();
  //       }
  //     });
  //   }
  // };

  this.showRecipeLabel = function(element) {
    if (element.nodeType === 1) {
      $(element).transition({
        animation: "zoom in",
      });
    }
  };
  this.hideRecipeLabel = function(element) {
    if (element.nodeType === 1) {
      $(element).transition({
        animation: "zoom out",
        onHide: function() {
          $(element).remove();
        }
      });
    }
  };

  // this.recipies.subscribe(function(changes) {
  //   changes.forEach(function(change) {
  //     // alert(change.status);
  //     if (change.status === "added") {
  //       // $(".recipe-card").transition();
  //     }
  //   });
  // }, null, "arrayChange");
}
/////// KnockOutJs Custom Bindings
ko.bindingHandlers.checkRecipePined = {
  "init": function(element, valueAccessor, allBindings, viewModel) {
    $(element).hide();
  },
  "update": function(element, valueAccessor, allBindings, viewModel) {
    if ($.grep(app.recipeLabels(), function(item) { return item.prog_id === viewModel.prog_id;}).length !== 0) {
      $(element).show();
    } else {
      $(element).hide();
    }
  }
}

ko.bindingHandlers.checkRecipeActive = {
  "update": function(element, valueAccessor, allBindings, viewModel, bindingContext) {
    var value = valueAccessor();
    var varlueUnwrapped = ko.unwrap(value);

    if (bindingContext.$data.prog_id === varlueUnwrapped.prog_id) {
      $(element).addClass("active").removeClass("basic");
      window.recipeLabelsContainer_OSIns.scroll({el: $(element), block: "center"}, 200);
    } else {
      $(element).addClass("basic").removeClass("active");
    }
  }
}
// ko.bindingHandlers.recipeCardTrans = {
//   'update': function (element, valueAccessor, allBindings) {
//     var value = valueAccessor();
//     var valueUnwrapped = ko.unwrap(value);
//     $(element).transition({
//       animation: "fly down",
//       reverse: true,
//     });
//   }
// };
// ko.applyBindings(new AppViewModel(), document.querySelector("#APM-App"));
///////////////////////////////////////////////////////////////////////////////
