var timer;

$(function(){
 	$('.input_alarm_form').submit(function(){
      timerFunc();
      //callAlarm()
    });
    
 })

 function timerFunc(){
    //var year = Number(dateTime.substring(0,4));
    //var month = Number(dateTime.substring(4,6));
    //var day = Number(dateTime.substring(6,8));
    //var time = Number(dateTime.substring(8,10));
    //var minute = Number(dateTime.substring(10,12));
    //var second = Number(dateTime.substring(12,14));

    //var oprDate = new Date(year, month-1, day, time, minute, second); 
    var alarmeNo = $('.input_alarm_form > input[name="alarmeNo"]').val();
    var hour = $('span > input[name="hour"]').val();
    var minute = $('span > input[name="minute"]').val();
    var oprDate = new Date(); 
    oprDate.setHours(hour);
    oprDate.setMinutes(minute);
    var nowDate = new Date();

    if(oprDate.getHours() < nowDate.getHours()){
       oprDate.setDate(oprDate.getDate() + 1);
    }else if(oprDate.getHours() == nowDate.getHours()){
       if(oprDate.getMinutes() < nowDate.getMinutes()){
         oprDate.setDate(oprDate.getDate() + 1);
       }
    }
    var time = oprDate.getTime() - nowDate.getTime(); 
    /*if(timer < 0){ 
       return;
    }else{
       setTimeout(func, timer);
    }*/
    //timer = setTimeout(callAlarm(alarmeNo), time);
    timer = setTimeout(function(){
      var data = 'alarmNo=' + alarmNo;
      $.ajax({
         url: "callAlarm",
               type: 'get',
               dataType: 'json',
               data: data,
               success: function(resultData){
                  $.each(resultData, function(index, value){
                     switch (index) {
                        case 0:
                           alert(value.scheduleTitle);
                           break;
                     
                        default:
                           break;
                     }
                     clearTimeout(timer);
                     timer = setTimeout(callAlarm(), 86400000);
                  });
               }
      });
    }, time);
}

function callAlarm(alarmNo){

   var data = 'alarmNo=' + alarmNo;
   $.ajax({
      url: "callAlarm",
            type: 'get',
            dataType: 'json',
            data: data,
            success: function(resultData){
               $.each(resultData, function(index, value){
                  switch (index) {
                     case 0:
                        alert(value.scheduleTitle);
                        break;
                  
                     default:
                        break;
                  }
                  clearTimeout(timer);
                  timer = setTimeout(callAlarm(), 86400000);
               });
            }
   });
   
}


 