/*
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/

function MonthPage(data){

    //constructor
    var _initData = data;
    _bindEvents();

    //private methods
    function _bindEvents(){
        $('.date.future:not(.weekend)').click(_onDateClick);
    }

    function _onDateClick(e){
        var thisRef = this;
        var requestId = $(this).attr('request_id');
        if (requestId !== undefined && requestId !== null){
            _deleteRequest(requestId, function(resp){
                $(thisRef).removeClass("ordered").removeAttr('request_id');
            });
        } else{
            var date = $(this).attr('date');
            _createRequest(date, function(resp){
                $(thisRef).addClass("ordered").attr('request_id', resp.id);
            })
        }
    }

    function _createRequest(date, success){
        _ajax({
            url: _initData.create_url,
            type: 'GET',
            data: {
                date: date
            }
        }, 201, success);
    }

    function _deleteRequest(id, success){
        _ajax({
            url: _initData.delete_url + '/' + id,
            type: 'DELETE'
        }, 204, success);
    }

    function _ajax(params, acceptCode, successCallback){
        var defaultParams = {
            statusCode:{},
            complete: function(jqXHR) {
                if (jqXHR.status != acceptCode){
                    alert("Error. Status " + jqXHR.status);
                    location.reload();
                }
            }
        };
        defaultParams.statusCode[acceptCode] = successCallback;
        $.ajax($.extend(defaultParams, params));
    }

};
function MonthPage(data){

    //constructor
    var _initData = data;
    _bindEvents();

    //private methods
    function _bindEvents(){
        $('.date.future:not(.weekend)').click(_onDateClick);
    }

    function _onDateClick(e){
        var thisRef = this;
        var requestId = $(this).attr('request_id');
        if (requestId !== undefined && requestId !== null){
            _deleteRequest(requestId, function(resp){
                $(thisRef).removeClass("ordered").removeAttr('request_id');
            });
        } else{
            var date = $(this).attr('date');
            _createRequest(date, function(resp){
                $(thisRef).addClass("ordered").attr('request_id', resp.id);
            })
        }
    }

    function _createRequest(date, success){
        _ajax({
            url: _initData.create_url,
            type: 'GET',
            data: {
                date: date
            }
        }, 201, success);
    }

    function _deleteRequest(id, success){
        _ajax({
            url: _initData.delete_url + '/' + id,
            type: 'DELETE'
        }, 204, success);
    }

    function _ajax(params, acceptCode, successCallback){
        var defaultParams = {
            statusCode:{},
            complete: function(jqXHR) {
                if (jqXHR.status != acceptCode){
                    alert("Error. Status " + jqXHR.status);
                    location.reload();
                }
            }
        };
        defaultParams.statusCode[acceptCode] = successCallback;
        $.ajax($.extend(defaultParams, params));
    }

};
