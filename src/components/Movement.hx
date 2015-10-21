
package components;

import luxe.Component;
import luxe.Rectangle;

import phoenix.Vector;

class Movement extends Component
{

    public var yspeed:Float;
    public var xspeed:Float;
    public var bounds:Rectangle;
    public var killBounds:Rectangle;

    override function init()
    {
        if(killBounds == null && bounds != null)
        {
            killBounds.copy_from(bounds);
        }
    } //ready


    override function onfixedupdate(rate:Float):Void
    {
        trace('movement.onfixedupdate( )');

        entity.pos.x += xspeed * rate;
        entity.pos.y += yspeed * rate;

        if(entity.pos.x > killBounds.w
        || entity.pos.x < killBounds.x
        || entity.pos.y > killBounds.h
        || entity.pos.y < killBounds.y)
        {
            // trace('OUT OF SCENE trying to destroy myself ${entity.pos}');
            entity.destroy(true);
        }

        if(entity.pos.x > bounds.w) entity.pos.x = bounds.w;
        if(entity.pos.x < bounds.x) entity.pos.x = bounds.x;
        if(entity.pos.y > bounds.h) entity.pos.y = bounds.h;
        if(entity.pos.y < bounds.y) entity.pos.y = bounds.y;

    }

}