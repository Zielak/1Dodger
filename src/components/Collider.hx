
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

    public var testAgainst:String;
    
    public var hit:Bool = false;
    public var coldata:CollisionData;

    var arr:Array<Entity>;
    var otherComponent:Collider;

    override function init():Void
    {
        arr = new Array<Entity>();

        entity.events.listen('collider.hit', function(_){
            gotHit();
        });
    } // init


    override function update(rate:Float):Void
    {
        shape.position = entity.pos;
        hit = false;

        if(hit) return;

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
            coldata = Collision.test(shape, otherComponent.shape);
            
            if(coldata != null)
            {
                if(otherComponent.hit) continue;
                
                // Tell myself what I hit
                gotHit();
                
                // Tell the other one, that i hit him!
                otherComponent.entity.events.fire('collider.hit');
                
            }
        }
    }

    function gotHit():Void
    {
        hit = true;
    }

}

// typedef CollisionEvent = {
//     var entity:Entity;
// }
