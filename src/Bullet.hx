
package ;

import luxe.collision.shapes.Circle;
import luxe.Rectangle;
import luxe.Visual;

import phoenix.Vector;

import components.Movement;
import components.Collider;

typedef BulletOptions = {
    @:optional var yspeed:Float;
    @:optional var xspeed:Float;
}

class Bullet extends Visual
{
    public static inline var BULLET_R:Float = 5;

    public var bulletoptions:BulletOptions;

    var movement:Movement;
    var collider:Collider;


    override function init():Void
    {
        fixed_rate = 1/60;

        collider = new Collider({name:'collider'});
        collider.testAgainst = 'enemy';
        collider.shape = new Circle(0, 0, BULLET_R);

        movement = new Movement({name:'movement'});
        movement.yspeed = (bulletoptions.yspeed!=null) ? bulletoptions.yspeed : 0;
        movement.xspeed = (bulletoptions.xspeed!=null) ? bulletoptions.xspeed : 0;
        movement.bounds = new Rectangle(0, -10, Luxe.screen.w, Luxe.screen.h);
        movement.killBounds = new Rectangle(-10, 0, Luxe.screen.w+10, Luxe.screen.h+10);

        add(movement);
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