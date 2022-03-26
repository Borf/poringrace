"c:\program files\php\php.exe" %0
pause
<?php
$count = (count(scandir("deco"))-2);
for($i = 0; $i < $count*3; $i++)
{
    echo $i . "\n";
    $poi = (int)($i / $count);
    $deco = array(1+($i % ($count-1)));


    $sx = 200;
    $sy = 200;

    $img = imagecreatetruecolor($sx*6,$sy);
    imagesavealpha($img, true);
    imagealphablending($img, false);
    imagefill($img, 0, 0, imagecolorallocatealpha($img, 0,0,0,127));
    $positions = array(array(0,0), array(0,-5), array(0,-15), array(0,-15), array(0,-10), array(0,-5));
    $decopositions = array();
    $align = array();
    $offsets = array();

    $offsets["face"] = array(array(45,30,10), array(45,20,20), array(45,20,10), array(45,25,5), array(45,25,10), array(45,30,10));
    $offsets["face2"] = array(array(45,30,0), array(49,25,0), array(45,24,0), array(45,25,0), array(45,25,0), array(45,30,0));
    $offsets["head"] = array(array(40,25,10), array(40,28,15), array(40,25,10), array(45,20,0), array(40,25,10), array(40,25,10));
    $offsets["back"] = array(array(30,15,10), array(30,18,15), array(30,15,10), array(35,10,0), array(30,15,10), array(30,15,10));
    $offsets["back_behind"] = array(array(30,15,10), array(30,18,15), array(30,15,10), array(35,10,0), array(30,15,10), array(30,15,10));

    $align["face"] = array(0, 0.5);
    $align["face2"] = array(0, 0.5);
    $align["head"] = array(0.5, 1);
    $align["back"] = array(1, 0.5);
    $align["back_behind"] = array(1, 0.5);


    $decopositions[1] = array("face", 0, 0, 0); // smile mask
    $decopositions[2] = array("head", 0, 0, 0); // apple
    $decopositions[3] = array("head", 0, 10, 0); // eggshell
    $decopositions[4] = array("head", 0, 30, 0); // bunny
    $decopositions[5] = array("face", 20, 0, 0); // nose
    $decopositions[6] = array("head", -10, 20, 0); // xmas
    $decopositions[7] = array("back", -10, 20, 0); // spring
    $decopositions[8] = array("head", 10, 10, 0); // ribbon
    $decopositions[9] = array("head", 10, 50, 0); // munak hat
    $decopositions[10] = array("head", 0, 30, 0); // purple ribbon
    $decopositions[11] = array("head", 0, 30, 0); // sakkat
    $decopositions[12] = array("head", 0, 20, 0); // gloomy
    $decopositions[13] = array("head", -20, 40, 0); // bapho jr
    $decopositions[14] = array("head", -10, 10, 0); // gentleman top hat
    $decopositions[15] = array("face", -10, 0, 0); // alchemy beak
    $decopositions[16] = array("head", -10, 30, 0); // stapo hat
    $decopositions[17] = array("head", 0, -5, 0); // cooking
    $decopositions[18] = array("head", 15, 0, 0); // turtle
    $decopositions[19] = array("head", 0, 20, 0); // yuno garrison
    $decopositions[20] = array("head", 10, 5, 0); // midgard helm
    $decopositions[21] = array("head", 15, -5, -10); // parcel hat
    $decopositions[22] = array("head", 0, 20, -10); // wizzard hat
    $decopositions[23] = array("face", 25, 20, 0); // romantic leaf
    $decopositions[24] = array("face2", -40, 0, 0); // glasses
    $decopositions[25] = array("head", 10, -10, -10); // biretta
    $decopositions[26] = array("face", 10, 5, 0); // goblin mask
    $decopositions[27] = array("head", -10, 20, 0); // hibiscus
    $decopositions[28] = array("back_behind", 20, 0, 0); // quiver
    $decopositions[29] = array("back_behind", 0, 30, 0); // fox tail
    $decopositions[30] = array("head", -5, 25, 0); // orc hero helmet
    $decopositions[31] = array("head", 0, 10, -10); // orc helmet
    $decopositions[32] = array("head", -10, 15, 0); // jewel crown
    $decopositions[33] = array("head", 0, 5, -10); // skull hat
    $decopositions[34] = array("face2", -50, 0, 0); // angry solo hat
    
    imagealphablending($img, false);
    $frames = array();
    for($frame = 0; $frame < 6; $frame++)
    {
        $f = imagecreatefrompng("poi/" . $poi . "/poi" . $frame . ".png");
        $frames[] = $f;
        imagecopy($img, $f, $sx*$frame + $sx/2 - imagesx($f)/2+ $positions[$frame][0], $sy*.75 - imagesy($f)/2 + $positions[$frame][1], 0,0,imagesx($f), imagesy($f));
    }
    imagealphablending($img, true);

    foreach($deco as $id)
        addDeco($id);

    imagepng($img, $i . ".png");
    //break;
}

function addDeco($id)
{
    global $img,$frames,$positions,$decopositions,$offsets,$align, $sx,$sy;
    $head = imagecreatefrompng("deco/".$id.".png");
    $type = $decopositions[$id][0];
    $offset = $offsets[$type];
    for($frame = 0; $frame < 6; $frame++)
    {
        if(strpos($type, "behind"))
        {
            $f = imagecreatetruecolor($sx, $sy);
            imagesavealpha($f, true);
            imagealphablending($f, false);
            imagefill($f, 0, 0, imagecolorallocatealpha($f, 0,0,0,127));
            imagealphablending($f, true);
            $rot = imagerotate($head, $offset[$frame][2] + $decopositions[$id][3], imagecolorallocatealpha($head, 0,0,0,127));
            imagecopy($f, $rot, 
                    $sx/2 - imagesx($frames[$frame])/2+ $positions[$frame][0] + $offset[$frame][0] - imagesx($rot)*$align[$type][0] + $decopositions[$id][1], 
                        $sy*.75 - imagesy($frames[$frame])/2 + $offset[$frame][1] + $positions[$frame][1] - imagesy($rot)*$align[$type][1] + $decopositions[$id][2], 
                        0,0,imagesx($rot), imagesy($rot));
            imagecopy($f, $img, 0, 0, $sx*$frame, 0, $sx, $sy);
            imagealphablending($img, false);
            imagecopy($img, $f, $sx*$frame, 0, 0, 0, $sx, $sy);
            imagealphablending($img, true);
        }
        else
        {
            $rot = imagerotate($head, $offset[$frame][2] + $decopositions[$id][3], imagecolorallocatealpha($head, 0,0,0,127));
            imagecopy($img, $rot, 
            $sx*$frame + $sx/2 - imagesx($frames[$frame])/2+ $positions[$frame][0] + $offset[$frame][0] - imagesx($rot)*$align[$type][0] + $decopositions[$id][1], 
                        $sy*.75 - imagesy($frames[$frame])/2 + $offset[$frame][1] + $positions[$frame][1] - imagesy($rot)*$align[$type][1] + $decopositions[$id][2], 
                        0,0,imagesx($rot), imagesy($rot));
        }
    }
}

?>