
package ;

import luxe.Sprite;

import phoenix.Color;
import phoenix.Vector;

import components.Movement;

typedef BulletOptions = {
    var pos:Vector;
    @:optional var yspeed:Float;
    @:optional var xspeed:Float;
}

class Bullet extends Sprite
{

    var movement:Movement;


    override public function new( options:BulletOptions ) {

        // uv = new Rectangle();

        // if(options == null) {
        //     throw "Sprite needs not-null options at the moment";
        // }

        //     //centered
        // if(options.centered != null) {
        //     centered = options.centered;
        // }

        //     //flipx
        // if(options.flipx != null) {
        //     flipx = options.flipx;
        // }

        //     //flipy
        // if(options.flipy != null) {
        //     flipy = options.flipy;
        // }

            //create visual
        var spriteoptions:luxe.options.SpriteOptions = {
            name_unique: true,
            name: 'bullet',
            pos: options.pos,
            color: new Color().rgb(0xFFFFAA),
            size: new Vector(10,10)
        };


        movement = new Movement({name:'movement'});
        movement.yspeed = options.yspeed;
        movement.xspeed = options.xspeed;

        super( spriteoptions );
    } // new

    override function init():Void
    {
        fixed_rate = 1/60;
        add(movement);
    }
}