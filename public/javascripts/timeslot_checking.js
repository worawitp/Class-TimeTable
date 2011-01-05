function check_timeslot_num(value){
    //alert(value);
    for(i=1;i<=3;i++){
        var timeslot_div=document.getElementById("timeslot"+i);
        if(timeslot_div){
            if(i<=value){
                timeslot_div.style.visibility="visible";
                timeslot_div.style.display="block";
            }
            else{
                timeslot_div.style.visibility="hidden";
                timeslot_div.style.display="none";
            }
        }
    }
    return true;
}

function set_time_slot(value,id){
    //alert(value);
    var time=value.split(":");
    var hour=time[0];
    var min=time[1];

    var timeslot=document.getElementById(id);
    //timeslot.removeChild();
    while(timeslot.childNodes.length>1){
        timeslot.options[0]=null;
        //alert(timeslot.childNodes.length);
    }
    //alert(timeslot);
    for(h=hour; h<20;){
        if(min=="00"){
            min="30"
            timeslot.appendChild(new Option(h+":"+min,h+":"+min));

        }
        else{
            h++;
            if(h<10)
                h="0"+h;
            min="00"
            timeslot.appendChild(new Option(h+":"+min,h+":"+min));
        }
    }
}