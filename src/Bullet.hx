
package ;

import luxe.collision.shapes.Circle;
import luxe.Rectangle;
import luxe.Sprite;

import phoenix.Vector;

import components.Collider;

class Bullet extends Sprite
{
    public static inline var BULLET_R:Float = 5;

    var collider:Collider;


    override function init():Void
    {
        fixed_rate = 1/60;

        collider = new Collider({name:'collider'});
        collider.testAgainst = 'enemy';
        collider.shape = new Circle(0, 0, BULLET_R);

        add(collider);
    }

    override function onfixedupdate(rate:Float):Void
    {
        if(collider.hit)
        {
            destroy(true);
        }
    }
    
}