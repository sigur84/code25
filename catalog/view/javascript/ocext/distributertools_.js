$(document).ready(function () {
        var good;
        var option_name;
        if (status_storekeeper == true){
        Storekeeper(1);
    }
        });
function  Storekeeper(some) {
               if (status_storekeeper == true){
                var array = [];        
                var hide = [];
                var show = [];                
                if (Number.isInteger(some)) {                
                $.ajax({
                url: 'index.php?route=product/distributer_tools_extecom/Storekeeper&product_id=' + product_id_distributer,
                        type: 'GET',
                        dataType: 'json',
                        success: function (json) {
                            
                        if(objLength(json)>0){
                            
                            good = json;
                        
                            for (var i in json) {
                                    var check = json[i].option_value_id;

                                    if (array.includes(check)) {
                                            var hideDub = json[i].product_option_value_id;
                                            $('#product :input[value="' + hideDub + '"]').parent().remove();
                                            $('#product select option[value="' + hideDub + '"]').remove();
                                    } else {
                                            var option_value_id = json[i].option_value_id;
                                            array.push(option_value_id);
                                            hideDub = json[i].product_option_value_id;
                                            $('#product :input[value="' + hideDub + '"]').attr('dataOVI', option_value_id).attr('onchange', 'Storekeeper($(this))');
                                            $('#product select option[value="' + hideDub + '"]').attr('dataOVI', option_value_id).attr('onchange', 'Storekeeper($(this))');
                                            $('#product select').attr('onchange', 'Storekeeper($(this))');
                                    }
                            }

                            addDataPovi();
                            
                        }
                        
                    }
                });
        }else { 
        option_name = some.attr("name");
                var option_value = some.val();
                if (option_value === '') {
        option_name = some.attr("name");
                $('#product select[name="' + option_name + '"] > option').removeAttr('disabled');
        } else {
        option_name = parseInt(option_name.replace(/\D+/g, ""));
                for (var i in good) {
        var check = good[i].product_option_value_id;
                if (option_value === check) {

        var option_value_id = good[i].option_value_id;
                var product_assortiment = productAssortiment(option_value_id);
                for (var k in good) {
        var checkOVI = good[k].option_value_id;
                var checkPai = good[k].product_assortiment_id;
                if (product_assortiment.includes(checkPai) && checkOVI !== option_value_id) {
        var findPovi = good[k].product_option_value_id;
                var name = good[k].name;
                var price_prefix = good[k].price_prefix;
                var price = good[k].price;
                show[findPovi] = {findPovi, name, price_prefix, price, checkOVI};
                var hidePoi = good[k].product_option_id;
                if (!hide.includes(hidePoi)) {
        hide.push(hidePoi);
        }

        }
        }
        }
        }
        
        hideData(hide);
        checkOvid(show,some);
        }
        }

        }
        }
function productAssortiment(option_value_id) {
var product_assortiment = [];
        for (var i in good) {
var ovi = good[i].option_value_id;
        if (option_value_id === ovi) {
var pai = good[i].product_assortiment_id;
        product_assortiment.push(pai);
}
}

return product_assortiment;
        }
        
function addDataPovi() {
for (var i in good) {
 var checkold = good[i].option_value_id;
        var dataPOVI = good[i].product_option_value_id + ',';
        var old = $('#product :input[dataOVI="' + checkold + '"] , #product select option[dataOVI="' + checkold + '"]').attr('dataPOVI');
        if (old !== undefined) {
$('#product :input[dataOVI="' + checkold + '"]').attr('dataPOVI', old + dataPOVI);
        $('#product select option[dataOVI="' + checkold + '"]').attr('dataPOVI', old + dataPOVI);
} else {
$('#product :input[dataOVI="' + checkold + '"]').attr('dataPOVI', dataPOVI);
        $('#product select option[dataOVI="' + checkold + '"]').attr('dataPOVI', dataPOVI);
}
}
return false;
        }
        
function chengeData(show) { 
    
        for (var z in show) {

        $("#product input[name='option[" + option_name + "]']").attr('disabled', false);
        $("#product input[name='option[" + option_name + "][]']").attr('disabled', false);
        $("#product select[name='option[" + option_name + "]'] > option").attr('disabled', false);
        var clone = $('#product :input[dataOVI="' + show[z].checkOVI + '"]').clone().val(show[z].findPovi).attr('disabled', false);
        var imgnext = $('#product :input[dataOVI="' + show[z].checkOVI + '"]').next().clone();
        var  price = parseFloat(show[z].price);
        price =  price.toFixed(decimal_this);
        if (price < 1){
            var textAfter =' '+ show[z].name;
        }else{
            var textAfter =' '+ show[z].name + ' ('+dimension_this_left + show[z].price_prefix + price + dimension_this_right+ ')';
        }
        console.log(textAfter);
        $('#product :input[dataOVI="' + show[z].checkOVI + '"]').parent().html(clone).append(imgnext).append(textAfter);
        $('#product select option[dataOVI="' + show[z].checkOVI + '"]').val(show[z].findPovi).text(textAfter).attr('disabled', false);
}
checkReady();
}

function hideData(hide) {

for (var z in hide) {

        $("#product input[name='option[" + hide[z] + "]']").attr('disabled', true);
        $("#product input[name='option[" + hide[z] + "][]']").attr('disabled', true);
        $("#product select[name='option[" + hide[z] + "]'] > option").attr('disabled', true);
        $("#product select option[value='']").attr('disabled', false);
}

}

function checkReady() {
$("#product input , #product select option").each(function () {


var check = $(this);
if (check.attr('disabled') === 'disabled') {
        check.removeAttr("checked");
        check.removeAttr("selected");
}

});
}

function checkOvid(show,some){
            var lastShow = [];
            var showOVI = [];
            var uncheck = [];
            var check_option = [];
                    $("#product input , #product select option").each(function () {
            var check = $(this);
                    if (check.is(':checked') === true || check.is(':selected') === true) {
            var samovi = check.attr('dataovi');
                    if (samovi === undefined){
            } else{
            check_option.push(samovi);
            }
            }
            });
            
           
            
        for (var i in good.OVI){
        var check_optionin = good.OVI[i];        
        check_optionin = check_optionin.split('_');        
            if (checkArrayOvi(check_optionin, check_option)){
                for (var z in check_optionin){                   
                showOVI.push(check_optionin[z]);   
                
                }
           }
        }

        if(showOVI.length > 1){
        for (var i in show){
            
        var  check =  show[i].checkOVI;
        
            if (showOVI.includes(check)){                 
                var findPovi = show[i].findPovi;
                 var name = show[i].name;
                  var price_prefix = show[i].price_prefix;
                   var price = show[i].price;
                    var checkOVI = show[i].checkOVI;
             lastShow.push({findPovi, name, price_prefix, price, checkOVI});
            
            }
        }}else{
        lastShow = show;
        for (var i in good.OVI){
        var check_optionin = good.OVI[i];        
        check_optionin = check_optionin.split('_');        
            var check = checkArrayOviNo(check_optionin, check_option);
                for (var z in check){
                  var check1 =  check_optionin[z];
                uncheck.push(check1);
           }
        }
        }
          
        chengeData(show);
        unCheck(uncheck,some); 

}


function compareNumbers(a, b) {
return a - b;
}
        
        
        
function checkArrayOvi(check_optionin, check_option){
            check_optionin = check_optionin.sort(compareNumbers);
            check_option = check_option.sort(compareNumbers);       
            for (i=0,j=0; i<check_optionin.length && j<check_option.length;) {
               if (check_optionin[i] < check_option[j]) {
                   ++i;
               } else if (check_optionin[i] === check_option[j]) {
                   ++i; ++j;
               } else {
                   
                   return false;
               }
           }
           
           return j === check_option.length;
}

function checkArrayOviNo(check_optionin, check_option){           
            check_optionin = check_optionin.sort(compareNumbers);
            check_option = check_option.sort(compareNumbers);
            var n = 0;
            var unsetovi = [];
       for(var i in check_optionin){
           var check = check_optionin[i];
           if (!check_option.includes(check)){
               n++;
           }else{
              unsetovi.push(check);
              
           }
       }
      
           return unsetovi;
       
}
function unCheck(uncheck,some){
    
    var check = some.attr('dataOVI');
    if (check === undefined){
      check =  some.val();
      check = $("#product select option[value=" + check + "]").attr('dataovi');     
    }
    for (var i in uncheck){
        if( uncheck[i] !== check ){
         $("#product input[dataOVI=" + uncheck[i] + "]").removeAttr("checked");
         $("#product select option[dataOVI=" + uncheck[i] + "]").removeAttr("selected");
        
    }
    }
    }
   
function objLength(obj){
  var i=0;
  for (var x in obj){
    if(obj.hasOwnProperty(x)){
      i++;
    }
  } 
  return i;
}