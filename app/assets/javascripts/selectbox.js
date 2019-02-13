jQuery(function(){
  var original = $('.genre').html();
  $('.category').change('turbolinks:load',function(){
    var val1=$(this).val();
    $('.genre').html(original).find('option').each(function(){
      var val2=$(this).data('val');
      if(val1 != val2){
      $(this).remove();
      }
    });
    if($(this).val()==""){
      $('.genre').attr('disabled', 'disabled');
    }else {
      $('.genre').removeAttr('disabled');
    }
  });
});
// not(':first-child').r
