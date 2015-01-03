
package ;

import luxe.Sprite;

import phoenix.Vector;

import components.Input;
import components.Shooting;

class Player extends Sprite
{

    var movespeed:Float = 160;

    var input:Input;
    var shooting:Shooting;

    override function init()
    {
        fixed_rate = 1/60;


        input = new Input({name: 'input'});
        shooting = new Shooting({name: 'shooting'});

        add(input);
        add(shooting);




    } //ready



    override function onfixedupdate(rate:Float):Void
    {
        
        if(input.move)
        {
            moveplayer(rate);
        }

    }



    function moveplayer(rate:Float):Void
    {
        if(input.left)
        {
            pos.x -= movespeed * rate;
        }
        else if(input.right)
        {
            pos.x += movespeed * rate;
        }
    }

}
