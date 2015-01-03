
package components;

import luxe.Component;

import phoenix.Vector;

class Movement extends Component
{

    public var yspeed:Float;
    public var xspeed:Float;

    var realPos:Vector;

    override function init()
    {
        realPos = new Vector(pos.x,pos.y);
        trace(realPos);

    } //ready


    override function onfixedupdate(rate:Float):Void
    {
        realPos.x += xspeed * rate;
        realPos.y += yspeed * rate;

        if(realPos.x > Luxe.screen.w
        || realPos.x < 0
        || realPos.y > Luxe.screen.h
        || realPos.y < 0)
        {
            trace(realPos);
            trace('screen h = ${Luxe.screen.h}');
            trace('screen w = ${Luxe.screen.w}');
            entity.destroy(true);
        }

        pos.x = Math.round(realPos.x);
        pos.y = Math.round(realPos.y);
    }

}