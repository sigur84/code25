<div class="tab-pane" id="tab-assortiment">
              <div class="row">
                  
                  <?php if(!$text_new_product){ ?>
                  
                        <div class="col-sm-2">
                          <ul class="nav nav-pills nav-stacked" id="assortiment">
                            
                            <?php $assortiment_row = 0; ?>
                            <?php foreach ($product_assortiments as $product_assortiment) { ?>
                                <li><a href="#tab-assortiment<?php echo $assortiment_row; ?>" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$('a[href=\'#tab-assortiment<?php echo $assortiment_row; ?>\']').parent().remove(); $('#tab-assortiment<?php echo $assortiment_row; ?>').remove(); $('#assortiment a:first').tab('show');"></i> <?php echo $text_product_assortiment_name.' '.$product_assortiment['product_assortiment_id']; ?></a></li>
                            <?php $assortiment_row++; ?>
                            <?php } ?>
                            <li style="padding-top: 25px;">
                                <button type="button" onclick="addAssortiment();" data-toggle="tooltip" title="<?php echo $button_assortiment_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_assortiment_add; ?></button>
                            </li>
                          </ul>
                        </div>
                        <div class="col-sm-10">
                          <div class="tab-content">
                            <?php $assortiment_row = 0; ?>
                            <?php $assortiment_value_row = 0; ?>
                            <?php foreach ($product_assortiments as $product_assortiment) { ?>
                            <?php $assortiment_value_row = 0; ?>
                            <div class="tab-pane" id="tab-assortiment<?php echo $assortiment_row; ?>">
                              <input type="hidden" name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_id]" value="<?php echo $product_assortiment['product_assortiment_id']; ?>" />
                              <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-required<?php echo $assortiment_row; ?>"><?php echo $entry_required; ?></label>
                                <div class="col-sm-10">
                                  <select name="product_assortiment[<?php echo $assortiment_row; ?>][required]" id="input-required<?php echo $assortiment_row; ?>" class="form-control">
                                    <?php if ($product_assortiment['required']) { ?>
                                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                                    <option value="0"><?php echo $text_no; ?></option>
                                    <?php } else { ?>
                                    <option value="1"><?php echo $text_yes; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                                    <?php } ?>
                                  </select>
                                </div>
                              </div>
                              
                              <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-value<?php echo $assortiment_row; ?>"><?php echo $entry_quantity; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="product_assortiment[<?php echo $assortiment_row; ?>][quantity]" value="<?php echo $product_assortiment['quantity']; ?>" placeholder="<?php echo $entry_quantity; ?>" id="input-value<?php echo $assortiment_row; ?>" class="form-control" />
                                    </div>
                                </div>
                              
                              <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-required<?php echo $assortiment_row; ?>"><?php echo $entry_subtract; ?></label>
                                <div class="col-sm-10">
                                    <select name="product_assortiment[<?php echo $assortiment_row; ?>][subtract]" class="form-control">
                                          <?php if ($product_assortiment['subtract']) { ?>
                                          <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                                          <option value="0"><?php echo $text_no; ?></option>
                                          <?php } else { ?>
                                          <option value="1"><?php echo $text_yes; ?></option>
                                          <option value="0" selected="selected"><?php echo $text_no; ?></option>
                                          <?php } ?>
                                        </select>
                                </div>
                              </div>
                              
                              
                              
                              
                              
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-value<?php echo $assortiment_row; ?>">Модель</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="product_assortiment[<?php echo $assortiment_row; ?>][model]" value="<?php echo $product_assortiment['model']; ?>" placeholder="model" id="input-value<?php echo $assortiment_row; ?>" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-value<?php echo $assortiment_row; ?>">EAN</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="product_assortiment[<?php echo $assortiment_row; ?>][ean]" value="<?php echo $product_assortiment['ean']; ?>" placeholder="EAN" id="input-value<?php echo $assortiment_row; ?>" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-value<?php echo $assortiment_row; ?>">SKU</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="product_assortiment[<?php echo $assortiment_row; ?>][sku]" value="<?php echo $product_assortiment['sku']; ?>" placeholder="sku" id="input-value<?php echo $assortiment_row; ?>" class="form-control" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-value<?php echo $assortiment_row; ?>">JAN</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="product_assortiment[<?php echo $assortiment_row; ?>][jan]" value="<?php echo $product_assortiment['jan']; ?>" placeholder="jan" id="input-value<?php echo $assortiment_row; ?>" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-value<?php echo $assortiment_row; ?>">UPC</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="product_assortiment[<?php echo $assortiment_row; ?>][upc]" value="<?php echo $product_assortiment['upc']; ?>" placeholder="upc" id="input-value<?php echo $assortiment_row; ?>" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-value<?php echo $assortiment_row; ?>">MPN</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="product_assortiment[<?php echo $assortiment_row; ?>][mpn]" value="<?php echo $product_assortiment['mpn']; ?>" placeholder="mpn" id="input-value<?php echo $assortiment_row; ?>" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-value<?php echo $assortiment_row; ?>">ISBN</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="product_assortiment[<?php echo $assortiment_row; ?>][isbn]" value="<?php echo $product_assortiment['isbn']; ?>" placeholder="isbn" id="input-value<?php echo $assortiment_row; ?>" class="form-control" />
                                    </div>
                                </div>
                              
                              <div class="table-responsive">
                                <table id="assortiment-value<?php echo $assortiment_row; ?>" class="table table-striped table-bordered table-hover">
                                  <thead>
                                    <tr>
                                      <td class="text-left"><?php echo $entry_option_value; ?></td>
                                      <td class="text-right"><?php echo $entry_price; ?></td>
                                      <td class="text-right"><?php echo $entry_option_points; ?></td>
                                      <td class="text-right"><?php echo $entry_weight; ?></td>
                                      <td></td>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    <?php foreach ($product_assortiment['product_assortiment_value']['product_option_value'] as $product_option_value) { ?>
                                    <tr id="assortiment-value-row<?php echo $assortiment_row; ?>-<?php echo $assortiment_value_row; ?>">
                                      <td class="text-left"><select name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_value][<?php echo $assortiment_value_row; ?>][option_value_id]" class="form-control">
                                          <?php if (isset($option_values[$product_option_value['option_id']])) { ?>
                                          <?php foreach ($option_values[$product_option_value['option_id']] as $option_value) { ?>
                                          <?php if ($option_value['option_value_id'] == $product_option_value['option_value_id']) { ?>
                                          <option value="<?php echo $option_value['option_value_id']; ?>" selected="selected"><?php echo $option_value['name']; ?></option>
                                          <?php } else { ?>
                                          <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
                                          <?php } ?>
                                          <?php } ?>
                                          <?php } ?>
                                        </select>
                                          
                                        <input type="hidden" name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_value][<?php echo $assortiment_value_row; ?>][product_assortiment_value_id]" value="<?php echo $product_option_value['product_assortiment_value_id']; ?>" />
                                        <input type="hidden" name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_value][<?php echo $assortiment_value_row; ?>][product_option_value_id]" value="<?php echo $product_option_value['product_option_value_id']; ?>" />
                                        <input type="hidden" name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_value][<?php echo $assortiment_value_row; ?>][product_option_id]" value="<?php echo $product_option_value['product_option_id']; ?>" />
                                        <input type="hidden" name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_value][<?php echo $assortiment_value_row; ?>][option_id]" value="<?php echo $product_option_value['option_id']; ?>" />
                                      </td>
                                      <td class="text-right"><select name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_value][<?php echo $assortiment_value_row; ?>][price_prefix]" class="form-control">
                                          <?php if ($product_option_value['price_prefix'] == '+') { ?>
                                          <option value="+" selected="selected">+</option>
                                          <?php } else { ?>
                                          <option value="+">+</option>
                                          <?php } ?>
                                          <?php if ($product_option_value['price_prefix'] == '-') { ?>
                                          <option value="-" selected="selected">-</option>
                                          <?php } else { ?>
                                          <option value="-">-</option>
                                          <?php } ?>
                                        </select>
                                        <input type="text" name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_value][<?php echo $assortiment_value_row; ?>][price]" value="<?php echo $product_option_value['price']; ?>" placeholder="<?php echo $entry_price; ?>" class="form-control" /></td>
                                      <td class="text-right"><select name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_value][<?php echo $assortiment_value_row; ?>][points_prefix]" class="form-control">
                                          <?php if ($product_option_value['points_prefix'] == '+') { ?>
                                          <option value="+" selected="selected">+</option>
                                          <?php } else { ?>
                                          <option value="+">+</option>
                                          <?php } ?>
                                          <?php if ($product_option_value['points_prefix'] == '-') { ?>
                                          <option value="-" selected="selected">-</option>
                                          <?php } else { ?>
                                          <option value="-">-</option>
                                          <?php } ?>
                                        </select>
                                        <input type="text" name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_value][<?php echo $assortiment_value_row; ?>][points]" value="<?php echo $product_option_value['points']; ?>" placeholder="<?php echo $entry_points; ?>" class="form-control" /></td>
                                      <td class="text-right"><select name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_value][<?php echo $assortiment_value_row; ?>][weight_prefix]" class="form-control">
                                          <?php if ($product_option_value['weight_prefix'] == '+') { ?>
                                          <option value="+" selected="selected">+</option>
                                          <?php } else { ?>
                                          <option value="+">+</option>
                                          <?php } ?>
                                          <?php if ($product_option_value['weight_prefix'] == '-') { ?>
                                          <option value="-" selected="selected">-</option>
                                          <?php } else { ?>
                                          <option value="-">-</option>
                                          <?php } ?>
                                        </select>
                                        <input type="text" name="product_assortiment[<?php echo $assortiment_row; ?>][product_assortiment_value][<?php echo $assortiment_value_row; ?>][weight]" value="<?php echo $product_option_value['weight']; ?>" placeholder="<?php echo $entry_weight; ?>" class="form-control" /></td>
                                      <td class="text-left"><button type="button" onclick="$(this).tooltip('destroy');$('#assortiment-value-row<?php echo $assortiment_row; ?>-<?php echo $assortiment_value_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                    </tr>
                                    <?php $assortiment_value_row++; ?>
                                    <?php } ?>
                                  </tbody>
                                  <tfoot>
                                    <tr>
                                        <td colspan="5" class="text-left">
                                            <input type="text" name="assortiment<?php echo $assortiment_row ?>" value="" placeholder="<?php echo $entry_option; ?>" id="input-assortiment" class="form-control" />
                                        </td>
                                      
                                    </tr>
                                  </tfoot>
                                </table>
                              </div>
                              <script type="text/javascript"><!--
                                    
                                    $(document).ready(function() {
                                        addAssortimentValue(<?php echo $assortiment_row ?>);
                                    });
                                    
                                //--></script>
                              
                              
                              
                            </div>
                            <?php $assortiment_row++; ?>
                            <?php } ?>
                          </div>
                        </div>
                  
                  <script type="text/javascript"><!--
                      
                    var assortiment_row = <?php echo $assortiment_row; ?>;
                    var assortiment_value_row = <?php echo $assortiment_value_row; ?>;
                      
                    function addAssortimentValue(assortiment_row){
                                    
                                        $('input[name=\'assortiment'+assortiment_row+'\']').autocomplete({
                                            'source': function(request, response) {
                                                    $.ajax({
                                                            url: 'index.php?route=catalog/option/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                                                            dataType: 'json',
                                                            success: function(json) {
                                                                    response($.map(json, function(item) {
                                                                            return {
                                                                                    category: item['category'],
                                                                                    label: item['name'],
                                                                                    value: item['option_id'],
                                                                                    type: item['type'],
                                                                                    option_value: item['option_value']
                                                                            }
                                                                    }));
                                                            }
                                                    });
                                            },
                                            'select': function(item) {
                                                var option_value = item['option_value'];
                                                var html_option_value = '';
                                                for (var i in option_value) {
                                                    html_option_value += '<option value="' + option_value[i]["option_value_id"] + '">' + option_value[i]["name"] + '</option>';
                                                }
                                                html  = '<tr id="assortiment-value-row' + assortiment_row + '-' + assortiment_value_row + '">';
                                                html += '  <td class="text-left"><select name="product_assortiment[' + assortiment_row + '][product_assortiment_value][' + assortiment_value_row + '][option_value_id]" class="form-control">';
                                                html += html_option_value;
                                                html += '  </select><input type="hidden" name="product_assortiment[' + assortiment_row + '][product_assortiment_value][' + assortiment_value_row + '][product_option_value_id]" value="" />';
                                                html += '  <input type="hidden" name="product_assortiment[' + assortiment_row + '][product_assortiment_value][' + assortiment_value_row + '][product_option_id]" value="" />';
                                                html += '  <input type="hidden" name="product_assortiment[' + assortiment_row + '][product_assortiment_value][' + assortiment_value_row + '][option_id]" value="" /></td>';
                                                html += '  <input type="hidden" name="product_assortiment[' + assortiment_row + '][product_assortiment_value][' + assortiment_value_row + '][product_assortiment_value_id]" value="" /></td>';
                                                html += '    <option value="1"><?php echo $text_yes; ?></option>';
                                                html += '    <option value="0"><?php echo $text_no; ?></option>';
                                                html += '  </select></td>';
                                                html += '  <td class="text-right"><select name="product_assortiment[' + assortiment_row + '][product_assortiment_value][' + assortiment_value_row + '][price_prefix]" class="form-control">';
                                                html += '    <option value="+">+</option>';
                                                html += '    <option value="-">-</option>';
                                                html += '  </select>';
                                                html += '  <input type="text" name="product_assortiment[' + assortiment_row + '][product_assortiment_value][' + assortiment_value_row + '][price]" value="" placeholder="<?php echo $entry_price; ?>" class="form-control" /></td>';
                                                html += '  <td class="text-right"><select name="product_assortiment[' + assortiment_row + '][product_assortiment_value][' + assortiment_value_row + '][points_prefix]" class="form-control">';
                                                html += '    <option value="+">+</option>';
                                                html += '    <option value="-">-</option>';
                                                html += '  </select>';
                                                html += '  <input type="text" name="product_assortiment[' + assortiment_row + '][product_assortiment_value][' + assortiment_value_row + '][points]" value="" placeholder="<?php echo $entry_points; ?>" class="form-control" /></td>';
                                                html += '  <td class="text-right"><select name="product_assortiment[' + assortiment_row + '][product_assortiment_value][' + assortiment_value_row + '][weight_prefix]" class="form-control">';
                                                html += '    <option value="+">+</option>';
                                                html += '    <option value="-">-</option>';
                                                html += '  </select>';
                                                html += '  <input type="text" name="product_assortiment[' + assortiment_row + '][product_assortiment_value][' + assortiment_value_row + '][weight]" value="" placeholder="<?php echo $entry_weight; ?>" class="form-control" /></td>';
                                                html += '  <td class="text-left"><button type="button" onclick="$(this).tooltip(\'destroy\');$(\'#assortiment-value-row' + assortiment_row + '-' + assortiment_value_row + '\').remove();" data-toggle="tooltip" rel="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
                                                html += '</tr>';

                                                $('#assortiment-value' + assortiment_row + ' tbody').append(html);
                                                $('[rel=tooltip]').tooltip();
                                                
                                                assortiment_value_row++;
                                                
                                            }
                                        });
                                    
                                    }
                      
                    function addAssortiment(){
                        
                        var html  = '<div class="tab-pane" id="tab-assortiment' + assortiment_row + '">';
                            html += '	<div class="form-group">';
                            html += '	  <label class="col-sm-2 control-label" for="input-required' + assortiment_row + '"><?php echo $entry_required; ?></label>';
                            html += '	  <div class="col-sm-10"><select name="product_assortiment[' + assortiment_row + '][required]" id="input-required' + assortiment_row + '" class="form-control">';
                            html += '	      <option value="1"><?php echo $text_yes; ?></option>';
                            html += '	      <option value="0"><?php echo $text_no; ?></option>';
                            html += '	  </select></div>';
                            html += '	</div>';
                            html += '	<input type="hidden" name="product_assortiment[' + assortiment_row + '][product_assortiment_id]" value="" />';
                                html += '<div class="form-group">';
                                    html += '<label class="col-sm-2 control-label" for="input-value'+assortiment_row+'"><?php echo $entry_quantity; ?></label>';
                                    html += '<div class="col-sm-10">';
                                        html += '<input type="text" name="product_assortiment['+assortiment_row+'][quantity]" value="" placeholder="<?php echo $entry_quantity; ?>" id="input-value'+assortiment_row+'" class="form-control" />';
                                    html += '</div>';
                                html += '</div>';
                              
                              html += '<div class="form-group">';
                                html += '<label class="col-sm-2 control-label" for="input-required'+assortiment_row+'"><?php echo $entry_subtract; ?></label>';
                                html += '<div class="col-sm-10">';
                                    html += '<select name="product_assortiment['+assortiment_row+'][subtract]" class="form-control">';
                                          html += '<option value="1" selected="selected"><?php echo $text_yes; ?></option>';
                                          html += '<option value="0"><?php echo $text_no; ?></option>';
                                    html += '</select>';
                                html += '</div>';
                              html += '</div>';
                                html += '<div class="form-group">';
                                    html += '<label class="col-sm-2 control-label" for="input-value'+assortiment_row+'"><?php echo $entry_model; ?></label>';
                                    html += '<div class="col-sm-10">';
                                        html += '<input type="text" name="product_assortiment['+assortiment_row+'][model]" value="" placeholder="<?php echo $entry_model; ?>" id="input-value'+assortiment_row+'" class="form-control" />';
                                    html += '</div>';
                                html += '</div>';
                                html += '<div class="form-group">';
                                    html += '<label class="col-sm-2 control-label" for="input-value'+assortiment_row+'"><?php echo $entry_ean; ?></label>';
                                    html += '<div class="col-sm-10">';
                                        html += '<input type="text" name="product_assortiment['+assortiment_row+'][ean]" value="" placeholder="<?php echo $entry_ean; ?>" id="input-value'+assortiment_row+'" class="form-control" />';
                                    html += '</div>';
                                html += '</div>';
                                html += '<div class="form-group">';
                                    html += '<label class="col-sm-2 control-label" for="input-value'+assortiment_row+'"><?php echo $entry_sku; ?></label>';
                                    html += '<div class="col-sm-10">';
                                        html += '<input type="text" name="product_assortiment['+assortiment_row+'][sku]" value="" placeholder="<?php echo $entry_sku; ?>" id="input-value'+assortiment_row+'" class="form-control" />';
                                    html += '</div>';
                                html += '</div>';
                                html += '<div class="form-group">';
                                    html += '<label class="col-sm-2 control-label" for="input-value'+assortiment_row+'"><?php echo $entry_jan; ?></label>';
                                    html += '<div class="col-sm-10">';
                                        html += '<input type="text" name="product_assortiment['+assortiment_row+'][jan]" value="" placeholder="<?php echo $entry_jan; ?>" id="input-value'+assortiment_row+'" class="form-control" />';
                                    html += '</div>';
                                html += '</div>';
                                html += '<div class="form-group">';
                                    html += '<label class="col-sm-2 control-label" for="input-value'+assortiment_row+'"><?php echo $entry_upc; ?></label>';
                                    html += '<div class="col-sm-10">';
                                        html += '<input type="text" name="product_assortiment['+assortiment_row+'][upc]" value="" placeholder="<?php echo $entry_upc; ?>" id="input-value'+assortiment_row+'" class="form-control" />';
                                    html += '</div>';
                                html += '</div>';
                                html += '<div class="form-group">';
                                    html += '<label class="col-sm-2 control-label" for="input-value'+assortiment_row+'"><?php echo $entry_mpn; ?></label>';
                                    html += '<div class="col-sm-10">';
                                        html += '<input type="text" name="product_assortiment['+assortiment_row+'][mpn]" value="" placeholder="<?php echo $entry_mpn; ?>" id="input-value'+assortiment_row+'" class="form-control" />';
                                    html += '</div>';
                                html += '</div>';
                                html += '<div class="form-group">';
                                    html += '<label class="col-sm-2 control-label" for="input-value'+assortiment_row+'"><?php echo $entry_isbn; ?></label>';
                                    html += '<div class="col-sm-10">';
                                        html += '<input type="text" name="product_assortiment['+assortiment_row+'][isbn]" value="" placeholder="<?php echo $entry_isbn; ?>" id="input-value'+assortiment_row+'" class="form-control" />';
                                    html += '</div>';
                                html += '</div>';
                              
                              html += '<div class="table-responsive">';
                                html += '<table id="assortiment-value'+assortiment_row+'" class="table table-striped table-bordered table-hover">';
                                  html += '<thead>';
                                    html += '<tr>';
                                      html += '<td class="text-left"><?php echo $entry_option_value; ?></td>';
                                      html += '<td class="text-right"><?php echo $entry_price; ?></td>';
                                      html += '<td class="text-right"><?php echo $entry_option_points; ?></td>';
                                      html += '<td class="text-right"><?php echo $entry_weight; ?></td>';
                                      html += '<td></td>';
                                    html += '</tr>';
                                  html += '</thead>';
                                  html += '<tbody>';
                            
                            html += '<tfoot>';
                                html += '<tr>';
                                    html += '<td colspan="5" class="text-left">';
                                        html += '<input type="text" name="assortiment'+assortiment_row+'" assortiment_row="'+assortiment_row+'" assortiment_value_row="'+assortiment_value_row+'" value="" placeholder="<?php echo $entry_option; ?>" id="input-assortiment" class="form-control" />';
                                    html += '</td>';
                                html += '</tr>';
                              html += '</tfoot>';
                            html += '</table>';
                        
                        $('#tab-assortiment .tab-content').append(html);
                        
                        addAssortimentValue(assortiment_row);

                        $('#assortiment > li:last-child').before('<li><a href="#tab-assortiment' + assortiment_row + '" data-toggle="tab"><i class="fa fa-minus-circle" onclick=" $(\'#assortiment a:first\').tab(\'show\');$(\'a[href=\\\'#tab-assortiment' + assortiment_row + '\\\']\').parent().remove(); $(\'#tab-assortiment' + assortiment_row + '\').remove();"></i> <?php echo $button_assortiment_add; ?></li>');

                        $('#assortiment a[href=\'#tab-assortiment' + assortiment_row + '\']').tab('show');
                        
                        assortiment_row++;

                    }
                //--></script>
                  
                  
                  <?php }else{ ?>
                  
                        echo $text_new_product;
                  
                  <?php } ?>
                  
              </div>
    
    
            </div>