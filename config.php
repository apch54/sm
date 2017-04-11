<?php

//Name of product used by the socle
define('PRODUCT', 'snowman-escape');

$gameOptions = array(
	'duration' => 60,
	'pointEarned' => 2,
    'pointLost' => 15,
	'pointToLevel1' => 200,
    'winningLevel' =>1,
    'timingTemps'=> false,
    'percentToNextLevel' => 1.5,
    'life' => 3,
    'pointBonus' => 5,

    //Here You can add new specific parameters
    // sprite velocity on x axis
    'vx0' => 150 , // init velocity until score is 40 ( in pixel per second)
    'vx1' => 180 , // first acceleration till score is 150
    'vx2' => 210 , // last x velocity  
    'color_effect' => false

);
//

//REGIEREPLACE
