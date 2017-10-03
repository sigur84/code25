<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-amazon-login" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-check-circle"></i></button>
              <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
              <?php foreach ($breadcrumbs as $breadcrumb) { ?>
              <li><a  href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
              <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
    <style>
        .small_text{
            font-size: 9px;
            color: darkgray;
        }
        .small_text:hover{
            font-size: 9px;
            color: black;
        }
        .table_zebra tbody tr td:nth-child(2n+1){
           background: lemonchiffon;
        }
        .table_zebra tbody tr td:nth-child(2){
           background: none;
        }
        
        .alert-box{
            margin-bottom: 5px;
            margin-top: 5px;
            display: none;
        }
        
        .table-abc-analysis tr td:first-child{
            width: 25%;
        }
        
        .field-file{
            font-size: 15px;
            font-weight: bold;
            color: white;
            padding: 5px;
            text-align: center;
            background: #444;
        }
        
        optgroup{
            border-bottom: 1px solid #ccc;
            color:#bbb;
        }
        optgroup option{
            color:#444;
        }
        
        .error-border{
            border:3px solid red;
            background: bisque;
        }
        
        
        .setTemplateDataBtn{
            border:1px solid #dddddd;
            background: #bbbbbb;
        }
        
        .setTemplateDataBtnNeedSave{
            border:1px solid brown;
            background: red;
        }
        
        .field-view-file-data{
            font-size: 9px; color:#bbb;
        }
        
        .field-view-file-data:hover{
            background: white;
            color: black;
        }
        
        .info-box-modal{
        
            background: #888;
            color: white;
            padding: 10px;
            max-width: 600px;
            width: auto;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.5);
        }       
        
        .arrow{
            width: 0px;
            height: 0px;
            border: 5px solid transparent;
            /*border-top-color:orangered;*/
            margin: 0;
            padding: 0;
            float: left;
        }
        
        .arrow:before{
          content:'';
          width: 0px;
          height: 0px;
          border: 10px solid transparent;
          border-top-color: #888;
          display: inline-block;
          -webkit-transform: translate(20px, -33px);
        }
        .arrow.down{
            transform: rotate(0deg) translate(0px, 25px);
            -webkit-transform: rotate(0deg) translate(0px, 25px);
            -moz-transform: rotate(0deg) translate(0px, 25px);
            -o-transform: rotate(0deg) translate(0px, 25px);
            -ms-transform: rotate(0deg) translate(0px, 25px);
          }
          
          .vert_text {
            -webkit-transform: rotate(-90deg); /* не забываем префиксные свойства */
            -moz-transform: rotate(-90deg);
            -ms-transform: rotate(-90deg);
            -o-transform: rotate(-90deg);
            transform: rotate(-90deg);
          }
          
          #check_row_info{
          
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 0px;
          
          }
          .sh-tab a, .sh-tab a h2{
            background: #ddd !important;
            color: black;
            font-size: 18px;
            margin-bottom: 0px;
          }
          
          .sh-tab-n {
              border-bottom: 3px solid #ddd;
          }
          span[data-toggle="tooltip"]:after{
            font-family: FontAwesome;
            color: #1E91CF;
            content: "\f059";
            margin-left: 4px;
          }
          
          .help-box{
          
              padding: 10px;
              font-size: 12px;
              background: ivory;
          
          }
          
          .box-help-csv{
              border: 1px solid #888;
              background: white;
              padding: 3px;
              margin-top: 5px;
              margin-bottom: 5px;
          }
          
          .additional_forms h5{
          
             
          
          }
        
    </style>
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
          <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php if ($success) { ?>
        <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
          <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        
    <div class="panel panel-default">
    
        <div class="panel-body">

            <ul  class="nav nav-tabs" >
                <li><a  data-toggle="tab" href="#tab_setting"  ><?php echo $tab_setting; ?></a></li>
            </ul>

            <div class="tab_setting">
                <div id="tab-setting" class="tab-pane" >
                    <div class="row">
                        <div class="col-sm-12">				
                            <div class="tab-content">


                <form action="<?php echo $action_setting; ?>" method="post" enctype="multipart/form-data" id="form-general-setting">
    <table class="table table-bordered table-hover">
        <?php $setting_field = 'status'; ?>
        <tr>
            <td><?php echo ${'text_setting_'.$setting_field}; ?></td>
            <td>
                <select  class="form-control" name="distributer_tools_extecom[setting][<?php echo $setting_field; ?>]">
                    <?php if(isset($distributer_tools_extecom['setting'][$setting_field]) && $distributer_tools_extecom['setting'][$setting_field] == $setting_field){ ?>
                        <option selected="" value="<?php echo $setting_field; ?>"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                    <?php }else{ ?>
                        <option value="<?php echo $setting_field; ?>"><?php echo $text_enabled; ?></option>
                        <option selected="" value="0"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                </select>
            </td>
        </tr>
        <tr>
            <?php $setting_field = 'user_email'; ?>
            <td><?php echo ${'text_setting_'.$setting_field}; ?></td>
            <td>
                <input name="distributer_tools_extecom[setting][<?php echo $setting_field; ?>]" value="<?php if(isset($distributer_tools_extecom['setting'][$setting_field])) { echo $distributer_tools_extecom['setting'][$setting_field]; } else { echo ''; } ?>" class="form-control" />
            </td>
        </tr>
        <tr>
            <?php $setting_field = 'user_key'; ?>
            <td><?php echo ${'text_setting_'.$setting_field}; ?></td>
            <td>
                <input name="distributer_tools_extecom[setting][<?php echo $setting_field; ?>]" value="<?php if(isset($distributer_tools_extecom['setting'][$setting_field])) { echo $distributer_tools_extecom['setting'][$setting_field]; } else { echo ''; } ?>" class="form-control" />
            </td>
        </tr>
        <?php $setting_field = 'delete_product_option'; ?>
        <tr>
            <td><?php echo ${'text_setting_'.$setting_field}; ?></td>
            <td>
                <select  class="form-control" name="distributer_tools_extecom[setting][<?php echo $setting_field; ?>]">
                    <?php if(isset($distributer_tools_extecom['setting'][$setting_field]) && $distributer_tools_extecom['setting'][$setting_field] == $setting_field){ ?>
                        <option selected="" value="<?php echo $setting_field; ?>"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                    <?php }else{ ?>
                        <option value="<?php echo $setting_field; ?>"><?php echo $text_enabled; ?></option>
                        <option selected="" value="0"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                </select>
            </td>
        </tr>
        
        <?php $setting_field = 'assortiment_categories'; ?>
        <tr>
            <td><?php echo ${'text_setting_'.$setting_field}; ?></td>
            <td>
        <?php if($categories){ ?>
            <div class="scrollbox" style="max-height: 250px; min-height: 50px; overflow-y: auto; margin-top: 7px;">

                <?php foreach($categories as $category){ ?>
                        <div style="min-height: 15px;">
                        <?php if(isset($distributer_tools_extecom['setting'][ $setting_field ][ $category['category_id'] ] )){ ?>
                            
                                <input checked="" type="checkbox"  name="distributer_tools_extecom[setting][<?php echo $setting_field; ?>][<?php echo $category['category_id'] ?>]" value="<?php echo $category['category_id'] ?>" />
                                <?php echo $category['name']; ?>
                            
                        <?php }else{ ?>
                        
                                <input type="checkbox"  name="distributer_tools_extecom[setting][<?php echo $setting_field; ?>][<?php echo $category['category_id'] ?>]" value="<?php echo $category['category_id'] ?>" />
                                <?php echo $category['name']; ?>
                                
                        <?php } ?>

                        </div>
                        
                <?php } ?>
            </div>
            <?php }else{ ?>
                <div class="alert-info" style="margin-top: 7px;" align="center"><?php echo ${'text_setting_'.$setting_field.'_empty'} ?></div>
            <?php } ?>
            </td>
        </tr>
        
        
        
        
    </table>
                </form>

                            </div>
                        </div>
                    </div>
                </div>     
            </div>
            
            <div id="ocext_notification" class="alert alert-info"><i class="fa fa-info-circle"></i>
                        
                            <div id="ocext_loading"><img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /></div>
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            
                    </div>
            
        </div>        
    </div>
</div>
</div>
<script type="text/javascript"><!--


    
$(document).ready(function() {
    $("a[href=\'#<?php echo $open_tab ?>\']").click();
    
});

function getNotifications() {
	$.ajax({
            type: 'GET',
            url: 'index.php?route=<?php echo $path_oc; ?>/distributer_tools_extecom/getNotifications&token=<?php echo $token; ?>',
            dataType: 'json',
            success: function(json) {
                    if (json['error']) {
                            $('#ocext_notification').html('<i class="fa fa-info-circle"></i><button type="button" class="close" data-dismiss="alert">&times;</button> '+json['error']);
                    } else if (json['message'] && json['message']!='' ) {
                            $('#ocext_notification').html('<i class="fa fa-info-circle"></i><button type="button" class="close" data-dismiss="alert">&times;</button> '+json['message']);
                    }else{
                        $('#ocext_notification').remove();
                    }
            },
            failure: function(){
                    $('#ocext_notification').remove();
            },
            error: function() {
                    $('#ocext_notification').remove();
            }
    });
}
getNotifications();

//--></script> 
<?php echo $footer; ?>