
package components;

import luxe.Component;

import phoenix.Vector;

class Movement extends Component
{

    public var yspeed:Float;
    public var xspeed:Float;


    override function init()
    {

    } //ready


    override function onfixedupdate(rate:Float):Void
    {
        pos.x += xspeed * rate;
        pos.y += yspeed * rate;

        if(pos.x > Luxe.screen.w + 50
        || pos.x < -50
        || pos.y > Luxe.screen.h + 50
        || pos.y < -50)
        {
            // trace('OUT OF SCENE trying to destroy myself ${pos}');
            entity.destroy(true);
        }

        pos.x = Math.round(pos.x);
        pos.y = Math.round(pos.y);
    }

}