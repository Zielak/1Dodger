
package ;

import luxe.collision.shapes.Circle;
import luxe.collision.shapes.Polygon;
import luxe.Rectangle;
import luxe.Vector;
import luxe.Visual;

import phoenix.Color;
import phoenix.geometry.Geometry;
import phoenix.geometry.CircleGeometry;
import phoenix.geometry.QuadGeometry;

import components.Bounce;
import components.Collider;
import components.Movement;

typedef EnemyEvent = {
    var enemy:Enemy;
}

class Enemy extends Visual
{

    public var enemytype:Int    = 0;
    public var health:Int       = 1;


    var size_health_mult:Float  = 12;

    // var geometry:Geometry;
    var movement:Movement;
    @:isVar public var collider(default,null):Collider;

    var _size:Float;
    var _rotation:Float;

    var _colorFlashBase:Color;
    var _colorFlashCounter:Float;
    var _colorFlashMax:Float    = 0.1;

    override public function init():Void
    {
        fixed_rate = 1/60;

        pickProperties();

        collider = new Collider({name:'collider'});
        collider.hit = false;
        add(collider);

        movement = new Movement({name:'movement'});
        movement.yspeed = 30 + (-health + 4) * 80 - Math.random()*30;
        movement.xspeed = 0; // (Math.random()-0.5) * 50;
        movement.bounds     = new Rectangle(10, -200, Luxe.screen.w-10, Luxe.screen.h+300);
        movement.killBounds = new Rectangle(-10, -300, Luxe.screen.w+10, Luxe.screen.h);
        add(movement);

        redraw();
    }


    function pickProperties():Void
    {
        _size     = Math.random() * 15 + 10;
        health    = Math.ceil(Math.random()*3);
        enemytype = Math.floor( Math.random()*3 );
        _rotation = (Math.random()-0.5)*50;

        rotation_z = Math.random() * 180;
    }

    function redraw():Void
    {
        switch (enemytype) {
            case 0: drawSquare();
            case 1: drawCircle();
            case 2: drawTriangle();
            default: drawSquare();
        }
        _colorFlashBase = color;
        
        movement.yspeed += (-health + 4) * 10;
    } // redraw


    function drawSquare():Void
    {
        var s:Float = _size + health*size_health_mult;
        geometry = Luxe.draw.box({
            x : -s/2, y : -s/2,
            w : s,
            h : s,
            color : color
        });

        collider.shape = Polygon.rectangle(-s/2, -s/2, s, s);
    } // drawSquare

    function drawCircle():Void
    {
        var s:Float = _size/2 + health*size_health_mult;
        geometry = Luxe.draw.circle({
            x : 0, y : 0,
            r : s,
            color : color
        });

        collider.shape = new Circle(0, 0, s);
    } // drawCircle

    function drawTriangle():Void
    {
        var s:Float = _size/1.5 + health*size_health_mult;
        geometry = Luxe.draw.ngon({
            x : 0, y : 0,
            r: s,
            sides : 3,
            solid : true,
            color: color
        });

        collider.shape = Polygon.triangle(0, 0, s);
    } // drawTriangle


    override function update(rate:Float):Void
    {
        if(collider.hit)
        {
            health--;
            if(health<=0)
            {
                Luxe.events.fire('enemy.destroyed', {enemy:this});
                destroy(true);
            }
            else
            {
                if(has('bounce'))
                {
                    remove('bounce');
                }
                switch (enemytype) {
                    case 0: hitSquare();
                    case 1: hitCircle();
                    case 2: hitTriangle();
                    default: hitSquare();
                }
                Luxe.events.fire('enemy.damaged', {enemy:this});
                redraw();

                _rotation += (_rotation>0) ? 100 : -100;
            }
        }

        // Flash if just hit
        if(collider.hit)
        {
            _colorFlashCounter = _colorFlashMax;
        }
        if(_colorFlashCounter > 0)
        {
            _colorFlashCounter -= rate;
            color = new Color(1,1,1,1);
        }
        else if(_colorFlashCounter < 0)
        {
            _colorFlashCounter = 0;
            color = _colorFlashBase;
        }

        // Rotate me
        rotation_z += _rotation * rate;
    }



    function hitSquare():Void
    {
        var bounce = new Bounce({name:'bounce'});
        bounce.velocity = new Vector(0, -300);
        add(bounce);
    }
    function hitCircle():Void
    {
        var bounce = new Bounce({name:'bounce'});
        var _bx:Float = Math.random()*150+100;
        _bx *= (Math.random()>=0.5) ? 1 : -1;
        bounce.velocity = new Vector(_bx, -300);
        add(bounce);
    }
    function hitTriangle():Void
    {
        // TODO MULTIPLY
        var bounce = new Bounce({name:'bounce'});
        bounce.velocity = new Vector(0, -150);
        add(bounce);
    }

}