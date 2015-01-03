
package components;

import Bullet;

import luxe.Component;
import phoenix.Vector;

import components.Input;

class Shooting extends Component
{
        // Current cooldown
    public var cooldown:Float       = 0;
        // Max cd waiting time
    public var maxcooldown:Float    = 0.2;
        // How fast are the bullets
    public var bulletspeed:Float    = 90;


    var bullet:Bullet;

    var _input:Input;

    override function init():Void
    {
        trace('shooting INIT()');
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
        trace('shooting FIRE()');
        cooldown = maxcooldown;

        bullet = new Bullet({
            pos: new Vector().copy_from(entity.pos),
            yspeed: -bulletspeed
        });
        Luxe.scene.add(bullet);
    }


}