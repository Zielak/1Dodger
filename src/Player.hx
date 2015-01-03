
package ;

import luxe.Sprite;

import phoenix.Vector;

import components.Input;
import components.Shooting;

class Player extends Sprite
{

    var movespeed:Float     = 0;
    var maxmovespeed:Float  = 360;
    var accelerate:Float    = 0.1;
    var decelerate:Float    = 0.8;

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
            // Add
        if(input.left)
        {
            movespeed -= maxmovespeed * accelerate;
        }
        else if(input.right)
        {
            movespeed += maxmovespeed * accelerate;
        }
        else
        {
            movespeed *= decelerate;
        }

            // Limit
        if(movespeed > maxmovespeed)
        {
            movespeed = maxmovespeed;
        }
        else if(movespeed < -maxmovespeed)
        {
            movespeed = -maxmovespeed;
        }

            // Apply
        pos.x += movespeed * rate;

        if(pos.x < 0)
        {
            pos.x = 0;
        }
        else if(pos.x > Luxe.screen.w)
        {
            pos.x = Luxe.screen.w;
        }
    }

}
