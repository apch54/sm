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
    // ----------.----------

    // sprite velocity on x axis
    'vx0' => 150 , // init velocity until score is 40 ( in pixel per second)
    'dvx' => 1.18,  // increase sprite velocity at score 50, 100 and 150

    // sprite vy at top  and low bounds; vyTop > 0 for below   
    'spriteVyTop'=> 100,   // better  between 50 and 250
    // bounce param when sprite collide platform
    'spriteVyLow'=> 350,  // better  over 300
    
    //sprite hight altmaw boundary
    'altmax_percent' => .8,

    // tint effect if true and 'color_effect'; only for platform collision
    // not for bonus one
    'color_effect' => false,

    // space between 2 dangers over the The same platform
    // 0 means space is at least danger.width
    'danger_space' => 0, 
    // max number of dangers PER platform
    'max_dangers'  => 1
);
//

//REGIEREPLACE

