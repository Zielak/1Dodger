
package components;

import Bullet;

import luxe.Component;
import luxe.Rectangle;
import phoenix.Color;
import phoenix.Vector;

import components.Input;

class Shooting extends Component
{
        // Current cooldown
    public var cooldown:Float       = 0;
        // Max cd waiting time
    public var maxcooldown:Float    = 0.25;
        // How fast are the bullets
    public var bulletspeed:Float    = 600;


    var _input:Input;

    override function init():Void
    {
        // trace('shooting INIT()');
        if(has('input'))
        {
            _input = get('input');
        }


    }

    override function update(dt:Float):Void
    {
        if(cooldown > 0)
        {
            cooldown -= dt;
        }
        if(cooldown < 0)
        {
            cooldown = 0;
        }

        if(cooldown == 0 && _input.fire)
        {
            fire();
        }
    }

    function fire():Void
    {
        // trace('shooting FIRE()');
        cooldown = maxcooldown;

        var bullet = new Bullet({
            name: 'bullet',
            name_unique: true,
            pos: new Vector().copy_from(entity.pos),
            color: new Color().rgb(0xFFFFAA),
            size: new Vector(Bullet.BULLET_R, Bullet.BULLET_R),
        });

        var movement = new Movement({name:'movement'});
        movement.yspeed = -bulletspeed;
        movement.xspeed = 0;
        movement.bounds = new Rectangle(0, -10, Luxe.screen.w, Luxe.screen.h);
        movement.killBounds = new Rectangle(-10, 0, Luxe.screen.w+10, Luxe.screen.h+10);
        bullet.add( movement );
    }


}