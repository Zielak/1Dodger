
package ;

import luxe.collision.shapes.Circle;
import luxe.collision.shapes.Polygon;
import luxe.Visual;

import phoenix.Color;
import phoenix.geometry.Geometry;
import phoenix.geometry.CircleGeometry;
import phoenix.geometry.QuadGeometry;

import components.Movement;
import components.Collider;

class Enemy extends Visual
{

    public var enemytype:Int    = 0;
    public var health:Int       = 1;

    // var geometry:Geometry;
    var movement:Movement;
    var collider:Collider;

    var _size:Float;

    override public function init():Void
    {
        fixed_rate = 1/60;

        pickProperties();

        collider = new Collider({name:'collider'});
        collider.keepTesting = false;

        switch (enemytype) {
            case 0: attachSquare();
            case 1: attachCircle();
            case 2: attachTriangle();
            default: attachSquare();
        }
        // add(geometry);


        movement = new Movement({name:'movement'});
        movement.yspeed = 100;
        movement.xspeed = 0; // (Math.random()-0.5) * 50;

        add(movement);
        add(collider);
    }


    function pickProperties():Void
    {
        _size = Math.random() * 20 + 10 + health*5;

        enemytype = Math.floor( Math.random()*3 );
    }


    function attachSquare():Void
    {
        geometry = Luxe.draw.box({
            x : 0, y : 0,
            w : _size,
            h : _size,
            color : new Color(0,0,0,0.5)
        });

        collider.shape = Polygon.rectangle(0, 0, _size, _size);
    }
    function attachCircle():Void
    {
        geometry = Luxe.draw.circle({
            x : 0, y : 0,
            r : _size/2,
            color : new Color(0,0,0,0.1).rgb(0xffffff)
        });

        collider.shape = new Circle(0, 0, _size/2);
    }
    function attachTriangle():Void
    {
        geometry = Luxe.draw.ngon({
            x : 0, y : 0,
            r: _size/1.5,
            sides : 3,
            solid : true,
            color: new Color(1,1,1,0.1)
        });

        collider.shape = Polygon.triangle(0, 0, _size/1.5);
    }

    override function onfixedupdate(rate:Float):Void
    {
        // collider.position.copy_from(pos);


    }

}