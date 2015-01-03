
package ;

import luxe.Sprite;

import phoenix.Vector;

import components.Input;
import components.Shooting;

class Player extends Sprite
{

    var movespeed:Float = 80;

    var input:Input;
    var shooting:Shooting;

    var realPos:Vector;

    override function init()
    {
        fixed_rate = 1/60;

        realPos = new Vector(pos.x,pos.y);

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



        pos.x = Math.round(realPos.x);
        pos.y = Math.round(realPos.y);
    }



    function moveplayer(rate:Float):Void
    {
        if(input.left)
        {
            realPos.x -= movespeed * rate;
        }
        else if(input.right)
        {
            realPos.x += movespeed * rate;
        }
    }

}
