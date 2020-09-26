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
