
package components;

import luxe.Component;

import phoenix.Vector;

class Bounce extends Component
{

    public var velocity:Vector;


    override function init():Void
    {
        if(velocity == null)
        {
            velocity = new Vector(0,-100);
        }
    } // init

    override function onfixedupdate(rate:Float):Void
    {
        pos.x += velocity.x * rate;
        pos.y += velocity.y * rate;

        velocity.divideScalar(2);
        
        if(velocity.length <= 10)
        {
            trace('trying to remove myself');
            remove(name);
            trace('failed to remove myself?');
        }

    } // onfixedupdate

}