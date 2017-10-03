<?php


require_once('../admin/config.php');

require_once(DIR_SYSTEM . 'startup.php');
require_once(DIR_SYSTEM . 'library/currency.php');
require_once(DIR_SYSTEM . 'library/user.php');
require_once(DIR_SYSTEM . 'library/weight.php');
require_once(DIR_SYSTEM . 'library/length.php');

define('OPT_COLOR_ID', '3');
define('OPT_BRAND_ID', '1');
define('OPT_MATERIAL_ID', '7');
define('OPT_SIZE_ID', '14');

function getProductLine($g, $cat, $image, $descr, $db) {
    $res = '';
    
    $attrQuery = $db->query('SELECT * FROM oc_product_attribute where product_id='.$g['product_id']);
    $params = '';
    foreach ($attrQuery->rows as $attr) {
        if ($attr['option_id']==OPT_COLOR_ID) {
            $params = $params.'<param name="Цвет">'.$attr['text'].'</param>';
        } else if ($attr['option_id']==OPT_SIZE_ID) {
            $params = $params.'<param name="Размер">'.$attr['text'].'</param>';
        } else if ($attr['option_id']==OPT_MATERIAL_ID) {
            $params = $params.'<param name="Материал">'.$attr['text'].'</param>';
        } else if ($attr['option_id']==OPT_BRAND_ID) {
            $params = $params.'<param name="Бренд">'.$attr['text'].'</param>';
        }
    }
    
    $optQuery = $db->query('SELECT * FROM oc_product_option_value op, oc_option_value_description v where op.option_value_id=v.option_value_id and product_id='.$g['product_id']);
    $params = '';
    foreach ($optQuery->rows as $attr) {
        if ($attr['option_id']==OPT_COLOR_ID) {
            $params = $params.'<param name="Цвет">'.$attr['name'].'</param>';
        } else if ($attr['option_id']==OPT_SIZE_ID) {
            $params = $params.'<param name="Размер">'.$attr['name'].'</param>';
        } else if ($attr['option_id']==OPT_MATERIAL_ID) {
            $params = $params.'<param name="Материал">'.$attr['name'].'</param>';
        } else if ($attr['option_id']==OPT_BRAND_ID) {
            $params = $params.'<param name="Бренд">'.$attr['name'].'</param>';
        }
    }
    
    $namesQuery = $db->query("SELECT * FROM oc_product_oc_product_description_outer op where system_name = 'PROM' product_id=".$g['product_id']);
    $prName = $descr['name'];
    $prDescr = $descr['description'];
     foreach ($namesQuery->rows as $prom_names) {
        if ($prom_names['name']!='') {$prName = $prom_names['name'];}
        if ($prom_names['description']!='') {$prDescr = $prom_names['description'];}
    }
        
    $res = $res. '<offer available="true" id="'.$g['product_id'].'">
                <url>
                http://flowerpots.prom.ua/p450056812-gorschik-gladkij-1151006.html
                </url>
                <price>'.$g['price'].'</price>
                <currencyId>UAH</currencyId>
                <categoryId>'.$cat['category_id'].'</categoryId>
                '.$image.'
                <delivery>true</delivery>
                <name>'.$prName.'</name>
                <vendorCode>'.$g['product_id'].'</vendorCode>
                <description>'.$prDescr.'</description>
                '.$params.'
            </offer>';
    
    return $res;
    
}

function getOfferLine($g, $cat, $image, $descr, $pdo) {
    
    $q = 'SELECT * FROM oc_product_option_value op, oc_option_value_description v where op.option_value_id=v.option_value_id and product_id='.$g['product_id'];
    $optQuery = $pdo->query($q);
    $params = '';
    while ($opt = $optQuery->fetch()) {
        if ($opt['option_id']==13) {
            $params = $params.'<param name="Цвет">'.$opt['name'].'</param>';
        } else if ($opt['option_id']==14) {
            $params = $params.'<param name="Размер">'.$opt['name'].'</param>';
        } else if ($opt['option_id']==15) {
            $params = $params.'<param name="Материал">'.$opt['name'].'</param>';
        } else if ($opt['option_id']==16) {
            $params = $params.'<param name="Бренд">'.$opt['name'].'</param>';
        }   
        
    }
 
    echo '<offer available="true" id="'.$g['product_id'].'">
                <url>
                http://flowerpots.prom.ua/p450056812-gorschik-gladkij-1151006.html
                </url>
                <price>'.$g['price'].'</price>
                <currencyId>UAH</currencyId>
                <categoryId>'.$cat['category_id'].'</categoryId>
                '.$image.'
                <delivery>true</delivery>
                <name>'.$descr['name'].'</name>
                <vendorCode>'.$g['product_id'].'</vendorCode>
                <description>'.$descr['description'].'</description>
                '.$params.'
            </offer>';
    
}


function getVariantLine($g, $cat, $image, $descr, $db) {
    
    $res = '';
    
    $attrQuery = $db->query('SELECT * FROM oc_product_attribute where product_id='.$g['product_id']);
    $attr_params = '';
    foreach ($attrQuery->rows as $attr) {
        if ($attr['option_id']==OPT_MATERIAL_ID) {
            $attr_params = $attr_params.'<param name="Материал">'.$attr['text'].'</param>';
        } else if ($attr['option_id']==OPT_BRAND_ID) {
            $attr_params = $attr_params.'<param name="Бренд">'.$attr['text'].'</param>';
        }
    }
    
    $params = '';
    
    if ($colorsCount == 1) {
        $qSingleColor = 'SELECT * FROM oc_product_option_value op, oc_option_value_description v where op.option_id = 3 and op.option_value_id=v.option_value_id and product_id='.$g['product_id'];
        $optQuery = $db->query($qSingleColor);
        $params = '';
        if ($optQuery->num_rows) {
            $params = $params.'<param name="Цвет">'.$optQuery->row['name'].'</param>';
        }
    }
    
    if ($sizeCount == 1) {
        $qSingleSize = 'SELECT * FROM oc_product_option_value op, oc_option_value_description v where op.option_id = 14 and op.option_value_id=v.option_value_id and product_id='.$g['product_id'];
        $optQuery = $db->query($qSingleSize);
        $params = '';
        if ($optQuery->num_rows) {
            $params = $params.'<param name="Размер">'.$optQuery->row['name'].'</param>';
        }
    }
    
    $namesQuery = $db->query("SELECT * FROM oc_product_description_outer op where system_name = 'PROM' and product_id=".$g['product_id']);
    
    $prName = $descr['name'];
    $prDescr = $descr['description'];
    
    
     foreach ($namesQuery->rows as $prom_names) {
        if ($prom_names['name']!='') {$prName = $prom_names['name'];}
        if ($prom_names['description']!='') {$prDescr = $prom_names['description'];}
    }
    
    $res = $res.  '<offer available="true" id="'.$g['product_id'].'" group_id="'.$g['product_id'].'">
                <url>
                http://flowerpots.prom.ua/p450056812-gorschik-gladkij-1151006.html
                </url>
                <price>'.$g['price'].'</price>
                <currencyId>UAH</currencyId>
                <categoryId>'.$cat['category_id'].'</categoryId>
                '.$image.'
                <delivery>true</delivery>
                <name>'.$prName.'</name>
                <vendorCode>'.$g['product_id'].'</vendorCode>
                <description>'.$prDescr.'</description>
                '.$attr_params.$params.'
            </offer>';
    

    $opt_id=1;
    
    $variants_query = $db->query('SELECT * FROM oc_product_assortiment opa WHERE opa.product_id='.$g['product_id']);
    foreach ($variants_query->rows as $variant) {
        
        $varDescr_query = $db->query('SELECT * FROM oc_product_assortiment_value opav, oc_option_value_description oovd, oc_product_option_value opov WHERE oovd.option_value_id=opav.option_value_id AND opav.product_option_value_id=opov.product_option_value_id and product_assortiment_id='.$variant['product_assortiment_id']);
        $varDescr='';
//        echo '2-'.$variant['product_assortiment_id'].'-2';
        $add_opt_price = 0;
        foreach ($varDescr_query->rows as $var) {
        
            if ($var['option_id']==OPT_COLOR_ID) {
                $varDescr = $varDescr.'<param name="Цвет">'.$var['name'].'</param>';
            } else if ($var['option_id']==OPT_SIZE_ID) {
                $varDescr = $varDescr.'<param name="Размер">'.$var['name'].'</param>';
                $add_opt_price = $var['price'];
            }
        }
        
        $res = $res.  '<offer available="true" id="'.$g['product_id'].'-'.$opt_id.'" group_id="'.$g['product_id'].'">
                <url>
                http://flowerpots.prom.ua/p450056812-gorschik-gladkij-1151006.html
                </url>
                <price>'.($g['price']+$add_opt_price).'</price>
                <currencyId>UAH</currencyId>
                <categoryId>'.$cat['category_id'].'</categoryId>
                '.$image.'
                <delivery>true</delivery>
                <name>'.$descr['name'].'</name>
                <vendorCode>'.$g['product_id'].'</vendorCode>
                <description>'.$descr['description'].'</description>
                '.$attr_params.$varDescr.'
            </offer>';
        ++$opt_id;
        
    }
    
    return $res;
    
    
}

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

header("Content-Type: text/xml");
header("Expires: Thu, 19 Feb 1998 13:24:18 GMT");
header("Last-Modified: ".gmdate("D, d M Y H:i:s")." GMT");
header("Cache-Control: no-cache, must-revalidate");
header("Cache-Control: post-check=0,pre-check=0");
header("Cache-Control: max-age=0");
header("Pragma: no-cache");
 */
$fl_content = '<!DOCTYPE yml_catalog SYSTEM "shops.dtd">';
$fl_content = $fl_content. '<yml_catalog date="2017-02-25 09:25">
    <shop>
        <name>Интернет магазин "Gorshki"</name>
        <company>Интернет магазин "Gorshki"</company>
        <url>http://flowerpots.prom.ua/</url>
        <currencies>
            <currency id="USD" rate="CB"/>
            <currency id="KZT" rate="CB"/>
            <currency id="RUR" rate="CB"/>
            <currency id="BYN" rate="CB"/>
            <currency id="UAH" rate="1"/>
            <currency id="EUR" rate="CB"/>
        </currencies>
        <categories>';

$user = 'gorshki_user';
$pass = 'AMZ555amz';

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Config
$config = new Config();
$registry->set('config', $config);

//$pdo = new PDO('mysql:host=db12.freehost.com.ua;dbname=gorshki_opencart', $user, $pass, array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8'"));

$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);
$query = $db->query('SELECT * FROM oc_category c, oc_category_description d where c.category_id=d.category_id and d.language_id=4');
foreach ($query->rows as $result) {
    $fl_content = $fl_content. '<category id="'.$result['category_id'].'" parentId="'.$result['parent_id'].'">'.$result['name'].'</category>';
}

/*
$stmt = $pdo->query('SELECT * FROM oc_category c, oc_category_description d where c.category_id=d.category_id and d.language_id=4');
while ($row = $stmt->fetch())
{
    echo '<category id="'.$row['category_id'].'" parentId="'.$row['parent_id'].'">'.$row['name'].'</category>';
}
 * 
 */

$fl_content = $fl_content. '</categories>
        <offers>';


$goods = $db->query('SELECT * FROM oc_product'); //where product_id=547
foreach ($goods->rows as $g)
{
    if ($g['image']!=null&&$g['image']!='') {
        $image = '<picture>http://gorshki.com.ua/image/'.$g['image'].'</picture>';
    } else {
        $image = '';
    }
    
    $dscrQuery = $db->query('SELECT * FROM oc_product_description where language_id=4 and product_id='.$g['product_id']);
    if ($dscrQuery->num_rows) {
        $descr = $dscrQuery->row;
        $catQuery = $db->query('SELECT * FROM oc_product_to_category where product_id='.$g['product_id']);
        if ($catQuery->num_rows) {
            $cat = $catQuery->row;
            
            $isVariant_query = $db->query('select * from oc_product_assortiment WHERE product_id='.$g['product_id']);
            if ($isVariant_query->num_rows>1) {
                //echo 'collection ';
                $fl_content = $fl_content.getVariantLine($g, $cat, $image, $descr, $db, $nColors, $nSize);
            } else {
                $fl_content = $fl_content.getProductLine($g, $cat, $image, $descr, $db);
                //echo 'product ';
                
            }
            
            
            /*
            
            $nColors = $db->query('select count(*) from oc_product_option_value where option_id=3 and product_id='.$g['product_id']);
            if ($nColors->num_rows) {
                $isColorsVariants = true;
            } else {    
                $isColorsVariants = false;
            }
            
            
            $nSize = $db->query('select count(*) from oc_product_option_value where option_id=14 and product_id='.$g['product_id']);
            if ($nSize->num_rows) {
                $isSizeVariants = true;
            } else {    
                $isSizeVariants = false;
            }
            echo '7';
            if (!$isSizeVariants&&!$isColorsVariants) {
                echo '8';
                getOfferLine($g, $cat, $image, $descr, $db);
            } else {
                echo '9';
                getVariantLine($g, $cat, $image, $descr, $db, $nColors, $nSize); 
            }
            
             * 
             */
//            $colorQuery = $pdo->query('SELECT * FROM opencart.oc_product_option_value where option_id=13 and product_id='.$g['product_id']);
//            $colorQuery->
            
            
            
            
            
    
        
        }
    
    }
    
}


$fl_content = $fl_content. '  </offers>
</shop>
</yml_catalog>';


$filename = 'exp_'.date('Y-m-d_H:i:s').'.xml';
file_put_contents($filename, $fl_content);
$filename = 'exp_prom.xml';
file_put_contents($filename, $fl_content);


//echo $fl_content;

//echo $filename;

//header("Location: http://gorshki.com.ua/export/".$filename);
die();