// Custom short for boostrap table
function customSort(sortName, sortOrder, data) {
  var order = sortOrder === 'desc' ? -1 : 1
  data.sort(function (a, b) {
    var aa = +((a[sortName] + '').replace(/[^\d]/g, ''));
    var bb = +((b[sortName] + '').replace(/[^\d]/g, ''));
    if (aa < bb) {
      return order * -1
    }
    if (aa > bb) {
      return order
    }
    return 0
  });
}


var $table = $('#database-table');
var mydata =
[
    {
        "id": 0,
        "name": "test0",
        "price": "$0"
    },
    {
        "id": 1,
        "name": "test1",
        "price": "$1"
    },
    {
        "id": 2,
        "name": "test2",
        "price": "$2"
    },
    {
        "id": 3,
        "name": "test3",
        "price": "$3"
    },
    {
        "id": 4,
        "name": "test4",
        "price": "$4"
    },
    {
        "id": 5,
        "name": "test5",
        "price": "$5"
    },
    {
        "id": 6,
        "name": "test6",
        "price": "$6"
    },
    {
        "id": 7,
        "name": "test7",
        "price": "$7"
    },
    {
        "id": 8,
        "name": "test8",
        "price": "$8"
    },
    {
        "id": 9,
        "name": "test9",
        "price": "$9"
    },
    {
        "id": 10,
        "name": "test10",
        "price": "$10"
    },
    {
        "id": 11,
        "name": "test11",
        "price": "$11"
    },
    {
        "id": 12,
        "name": "test12",
        "price": "$12"
    },
    {
        "id": 13,
        "name": "test13",
        "price": "$13"
    },
    {
        "id": 14,
        "name": "test14",
        "price": "$14"
    },
    {
        "id": 15,
        "name": "test15",
        "price": "$15"
    }
];

$(function () {
    $('#database-table').bootstrapTable({
        data: mydata
    });
    console.log(mydata);
});


// For program card dropdown menu
$('.prog-card-id').on('contextmenu', function(e) {
  alert('hi');
  var top = e.pageY - 10;
  var left = e.pageX - 90;
  $("#prog-card-dropdown").css({
    display: "block",
    top: top,
    left: left
  }).addClass("show");
  return false; //blocks default Webbrowser right click menu
}).on("click", function() {
  $("#prog-card-dropdown").removeClass("show").hide();
});

$("#prog-card-dropdown a").on("click", function() {
  $(this).parent().removeClass("show").hide();
});

//  //Auto close boostrap alert message with auto-close="time" attribute
// $(function() {
// 	var alert = $('div.alert[auto-close]');
// 	alert.each(function() {
// 		var that = $(this);
// 		var timeout = that.attr('auto-close');
// 		setTimeout(function() {
// 			that.alert('close');
// 		}, timeout);
// 	});
// });

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
  var $content, $modal, $apnData, $modalCon;
  $content = $(".min");

  //To fire modal
  $(".toggle-modal").on("click", function(e) {
    alert('HERE!');
    e.preventDefault();
    var $id = $(this).attr("data-target");
    $($id).modal({
      backdrop: false,
      keyboard: false
    });
  });

  $(".modal-minimize").on("click", function() {
    $modalCon = $(this).closest(".mymodal").attr("id");
    $apnData = $(this).closest(".mymodal");
    $modal = "#" + $modalCon;
    $(".modal-backdrop").addClass("display-none");
    $($modal).toggleClass("min");
    if ( $($modal).hasClass("min") ){
      $(".minmaxCon").append($apnData);
      $(this).find("i").toggleClass( 'fa-minus').toggleClass( 'fa-clone');
    } else {
      $(".container").append($apnData);
      $(this).find("i").toggleClass( 'fa-clone').toggleClass( 'fa-minus');
    };
  });
  $("[data-dismiss='modal']").click(function(){
    $(this).closest(".mymodal").removeClass("min");
    $(".container").removeClass($apnData);
    $(this).next('.modalMinimize').find("i").removeClass('fa fa-clone').addClass( 'fa fa-minus');
  });
});
