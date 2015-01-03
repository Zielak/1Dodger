
package components;

import luxe.Component;
import luxe.collision.shapes.Shape;
import luxe.collision.shapes.Circle;
import luxe.collision.shapes.Polygon;
import luxe.collision.CollisionData;
import luxe.collision.Collision;
import luxe.Entity;

class Collider extends Component
{


    public var shape:Shape;

    public var keepTesting:Bool = true;
    public var testAgainst:String;

    var arr:Array<Entity>;
    var coldata:CollisionData;
    var otherComponent:Collider;

    override function init():Void
    {
        arr = new Array<Entity>();

        trace('shape: ${shape}');
    } // init

    override function onfixedupdate(rate:Float):Void
    {
        shape.position.copy_from(entity.pos);

        if(!keepTesting) return;

        arr = new Array<Entity>();
        arr = Luxe.scene.get_named_like(testAgainst, arr);
        // trace(arr.length);

        for(t in arr)
        {
            // Check if has collider component (just like this one)
            if(!t.has('collider'))
            {
                continue;
            }


            // Test if they collide!
            otherComponent = cast(t.get('collider'), Collider);
            coldata = Collision.test(cast(shape, Shape), cast(otherComponent.shape, Shape));
            if(coldata != null)
            {
                // Tell myself what I hit
                reportHit(otherComponent.entity);
                // Tell the other one, that i hit him!
                otherComponent.reportHit(entity);
            }
        }
    }

    function reportHit(_entity:Entity):Void
    {
        trace('REPORTED HIT!');
        entity.destroy(true);
    }

}