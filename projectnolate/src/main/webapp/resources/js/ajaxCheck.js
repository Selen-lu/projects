$(function(){
    
    $('.join_input_id > button').click(function(event){
        
        event.preventDefault();
  		var csrfHeader = $('.token').data("token-name");
    	var csrfToken = $('.token').val();
        var data = 'id=' + $('.join_input_id > input').val();

        $.ajaxSetup({
            beforeSend: function(xhr){
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        })

        $.ajax({
            url: "overlapID",
            type: 'post',
            dataType: 'json',
            data: data,
            success: function(resultData){
                var isOverlapId = resultData.isOverlapId;
                if(isOverlapId){
                    $('.join_input_id > .error_box').text("중복된 id입니다.");
                }
            },
            error: function(jqXHR, status, e){
                alert(status + " : " + e);
                return false;
            }
        })
    });

    $('.check_btn_area > button').click(function(event){
        event.preventDefault();
  		var csrfHeader = $('.token').data("token-name");
    	var csrfToken = $('.token').val();
        var data = 'pass=' + $('.check_input_password > input').val();

        $.ajaxSetup({
            beforeSend: function(xhr){
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        })

        $.ajax({
            url: "confirmPass",
            type: 'post',
            dataType: 'json',
            data: data,
            success: function(resultData){
                var isConfirm = resultData.isConfirm;
                if(isConfirm){
                    $('.check_pass_form').submit();
                }
                else{
                    $('.check_input_password > .error_box').text("비밀번호가 일치하지 않습니다.");
                }
            },
            error: function(jqXHR, status, e){
                alert(status + " : " + e);
                return false;
            }            
        })        
    });

    
});

