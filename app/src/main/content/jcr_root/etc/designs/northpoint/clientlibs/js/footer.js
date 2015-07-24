
  var resizeWindow = function(e) {
    //make sure fixVertical is defined.
    //if(typeof fixVerticalSizing != 'undefined' && fixVerticalSizing === true) {
      //get height of the actual page
      var currentMainHeight = $('.inner-wrap').height(),
          windowHeight = $(window).height(), //get the height of the window
          targetMainHeight = (windowHeight-currentMainHeight);
      //if the content of the page is not to the bottom of the window add this padding, note the row that is the wrapper
      //must have class content
      $('.vtk-body #main .row.content').css('padding-bottom','');
      $('#main.content').css('padding-bottom',''); 
      if(targetMainHeight > 0) {
        $('.vtk-body #main .row.content').first().css('padding-bottom',targetMainHeight + "px");
        $('#main.content').css('padding-bottom',targetMainHeight + "px");
      }
      else {
       $('.vtk-body #main .row.content').css('padding-bottom','');
       $('#main.content').css('padding-bottom','');
      }
  };
//need to add class for small screens only on the barter links.
  function addClassGrid() {
    if ($(window).width() < 640) {
        $('.barter-navigation > div:nth-of-type(1) ul').addClass('small-block-grid-2');
        $('.barter-navigation > div:nth-of-type(2) ul').css('text-align', 'center');
       }
       else {
        $('.barter-navigation > div:nth-of-type(1) ul').removeClass('small-block-grid-2');
        $('.barter-navigation > div:nth-of-type(2) ul').css('text-align', 'right');
      }
  }
  function link_bg_square() {
    $(".meeting").each(function() {
    var test = $(this).find('.subtitle a').attr('href');

      $(this).find('.bg-square').on('click', function(){
        location.href = test;
      })
    });
  }
  function attendance_popup_width() {
    var modal = $(".modal-attendance").parent();
    modal.addClass('small');
    var wd_wdth = $( window ).width();
    modal.width("40%");
    if($(window).width() > 641) {
      if(modal.width() < wd_wdth) {
        var middle = modal.width()/2;
        modal.css('margin-left',"-"+middle+'px');
      }
    } else {
      modal.width("100%");
      modal.css('margin-left','');
    }
  }
  function vtk_accordion() {
    $('.accordion dt > :first-child').on('click', function() {
      var target = $(this).parent().data('target');
      var toggle = $(this);
      $('#' + target).slideToggle('slow');
      $(toggle).toggleClass('on');
      if(window[ target ] != null){
    	  window[ target ].toggle();
      }
        return false;
    });
  }
$(document).ready(function(){
 resizeWindow();
 addClassGrid();
 vtk_accordion();
 attendance_popup_width();
})
$(window).load(function(){
  var currentMainHeight = $('.inner-wrap').height();
  //get the height of the window
  var windowHeight = $(window).height();
  var targetMainHeight = (windowHeight-currentMainHeight);
  if(targetMainHeight != 0) {
    resizeWindow();
    addClassGrid();
    attendance_popup_width();
  }
});
