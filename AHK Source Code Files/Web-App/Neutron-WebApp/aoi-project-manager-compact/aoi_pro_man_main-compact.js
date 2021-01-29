// ========================================================================= //
// Tooltips Initialization
$(function () {
  $('[tool="tooltip"]').tooltip({
    trigger : 'hover'
  });
  // Custom tooltip
  $('[tool="tooltip-success"]').tooltip({
    template: '<div class="tooltip t-success" role="tooltip"><div class="arrow"></div><div class="tooltip-inner"></div></div>'
  });
  $('[tool="tooltip-warning"]').tooltip({
    template: '<div class="tooltip t-warning" role="tooltip"><div class="arrow"></div><div class="tooltip-inner"></div></div>'
  });
  $('[tool="tooltip-alert"]').tooltip({
    template: '<div class="tooltip t-alert" role="tooltip"><div class="arrow"></div><div class="tooltip-inner"></div></div>'
  });
  $('[tool="tooltip-info"]').tooltip({
    template: '<div class="tooltip t-info" role="tooltip"><div class="arrow"></div><div class="tooltip-inner"></div></div>'
  });
  $('[tool="tooltip-secondary"]').tooltip({
    template: '<div class="tooltip t-secondary" role="tooltip"><div class="arrow"></div><div class="tooltip-inner"></div></div>'
  });
});

// ========================================================================= //
// Minimize and Maximize boostrap modal
$(function(){
  var $apnData, $modalElId, $modalId;
  //To fire modal
  $(document).on("click", ".toggle-modal", function(e) {
    e.preventDefault();
    $modalElId = $(this).attr("data-target");
    $modalId = $($modalElId).attr("id");
    $('body').addClass($modalId);

    $($modalElId).modal({
      focus: false,
      //backdrop: false,
      //keyboard: false
    });
  });

  //After fire modal
  // $(document).on("shown.bs.modal", $modalElId, function() {
  //   $modalId = $($modalElId).attr("id");
  //   $('body').addClass($modalId);
  // });
  //When close (hide) modal
  // $(document).on("hide.bs.modal", $modalElId, function() {
  //   $('body').removeClass($modalId);
  //   $($modalElId).removeClass("min");
  // });

  //Minimize-maximize modal
  $(document).on("click", ".modal-minimize", function() {
    $modalId = $(this).closest(".minmax-modal").attr("id");
    $modalElId = "#" + $modalId;
    $apnData = $(this).closest(".minmax-modal");

    $($modalElId).toggleClass("min");
    if ($($modalElId).hasClass("min")){   //Minimize
      $( "." + $modalId + " .modal-backdrop").addClass("d-none");
      $(".minmax-container").append($apnData);
      // $(this).find("i").toggleClass( 'fa-window-minimize').toggleClass( 'fa-window-restore');
    } else {  //Maximize
      $( "." + $modalId + " .modal-backdrop").removeClass("d-none");
      $(".app-container").append($apnData);
      // $(this).find("i").toggleClass( 'fa-window-restore').toggleClass( 'fa-window-minimize');
    };
  });

  //Close min-max modal
  $(document).on("click", ".minmax-modal [data-dismiss='modal']", function(){
    $modalId = $(this).closest(".minmax-modal").attr("id");
    $(this).closest(".minmax-modal").removeClass("min");
    $( "." + $modalId + " .modal-backdrop").addClass("d-none");
    $(".app-container").removeClass($apnData);
    //$(this).next('.modal-minimize').find("i").removeClass('fas fa-window-restore').addClass( 'fas fa-window-minimize');
  });

});
