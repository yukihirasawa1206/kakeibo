var select_month = new Date().getMonth();
var select_year = new Date().getFullYear();
jQuery(function(){
  $('.payment-record-list').each(function(index, element){
    str = $(element).find('.payment-record-date').text();
    month = new Date(str).getMonth();
    year = new Date(str).getFullYear();
    if(select_month != month || select_year != year) {
      $(element).hide();
    }
  });

  $('.minus-button').click(function(){
      $('.account-record-list').find('.payment-record-list').show();
      if(select_month > 0){
        select_month = select_month - 1;
      }
      else{
        select_month = 11;
        select_year = select_year - 1;
      }
      console.log(select_month, select_year)
    $('.payment-record-list').each(function(index, element){
      str = $(element).find('.payment-record-date').text();
      month = new Date(str).getMonth();
      year = new Date(str).getFullYear();
      if(select_month != month || select_year != year) {
        $(element).hide();
      }
    });
  });

  $('.plus-button').click(function(){
      $('.account-record-list').find('.payment-record-list').show();
      if(select_month == 11 ){
        select_month = 0;
        select_year = select_year + 1;
      }
      else{
        select_month = select_month + 1;
      }
      console.log(select_month, select_year)
    $('.payment-record-list').each(function(index, element){
      str = $(element).find('.payment-record-date').text();
      month = new Date(str).getMonth();
      year = new Date(str).getFullYear();
      if(select_month != month || select_year != year) {
        $(element).hide();
      }
    });
  });

});
