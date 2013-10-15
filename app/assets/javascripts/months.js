$(document).ready(function() {
    $("form").bind("ajax:complete", function(e, data, status, error){
        if (data.status === 200 || data.status === 201) {
            console.log($(this));
            $(this).parent().addClass("ordered");
            $(this).remove();
        }
    });
});