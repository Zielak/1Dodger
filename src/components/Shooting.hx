
package components;

import Bullet;

import luxe.Component;
import phoenix.Color;
import phoenix.Vector;

import components.Input;

class Shooting extends Component
{
        // Current cooldown
    public var cooldown:Float       = 0;
        // Max cd waiting time
    public var maxcooldown:Float    = 0.33;
        // How fast are the bullets
    public var bulletspeed:Float    = 340;


    var bullet:Bullet;

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

        bullet = new Bullet({
            name: 'bullet',
            name_unique: true,
            pos: new Vector().copy_from(entity.pos),
            color: new Color().rgb(0xFFFFAA),
            geometry: Luxe.draw.circle({
                x: 0, y: 0,
                r: Bullet.BULLET_R
            })
        });
        bullet.bulletoptions = {
            yspeed: -bulletspeed
        };
    }


}