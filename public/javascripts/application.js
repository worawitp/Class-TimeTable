// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function(){
    //all hover and click logic for buttons
    $(".ui-button:not(.ui-state-disabled)")
            .hover(
            function(){
                $(this).addClass("ui-state-hover");
            },
            function(){
                $(this).removeClass("ui-state-hover");
            }
            )

            .mousedown(
            function(){
                $(this).parents('.fg-buttonset-single:first').find(".fg-button.ui-state-active").removeClass("ui-state-active");
                if( $(this).is('.ui-state-active.fg-button-toggleable, .fg-buttonset-multi .ui-state-active') ){ $(this).removeClass("ui-state-active"); }
                else { $(this).addClass("ui-state-active"); }
            })
            .mouseup(
            function(){
                if(! $(this).is('.fg-button-toggleable, .fg-buttonset-single .fg-button,  .fg-buttonset-multi .fg-button') ){
                    $(this).removeClass("ui-state-active");
                }
            });
});

//function to be run after the document is ready
//hide the notice div
//modified source code from web8, 2010
$(function(){
    var notice = $("#notice");
    if (notice){
        setTimeout(function(){
            notice.fadeOut(1000,
                    function(){
                        notice.hide();
                    });
        },1500);

    }
});