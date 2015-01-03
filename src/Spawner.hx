
package ;

import luxe.Entity;
import luxe.Vector;

import phoenix.Color;

class Spawner extends Entity
{

    var cooldown:Float;
    var maxcooldown:Float = 3;

    var enemyCount:Int = 0;

    var enemy:Enemy;

    var newspawn:Vector;
    var lastspawn:Vector;

    override public function init():Void
    {
        cooldown = 0;
        lastspawn = new Vector(Luxe.screen.w/2, -10);
        newspawn = new Vector().copy_from(lastspawn);
    }


    override function update(dt:Float):Void
    {
        updateTimers(dt);
    }







    function updateTimers(dt:Float):Void
    {
        cooldown -= dt;
        if(cooldown < 0)
        {
            cooldown = 0;
        }
        if(cooldown == 0)
        {
            spawnEnemy();
        }
    } // updateTimers


    function spawnEnemy():Void
    {
        cooldown = maxcooldown;
        maxcooldown -= (maxcooldown > 0.6) ? 0.11 : 0;
        enemyCount++;

        newspawn = new Vector();
        newspawn.x = lastspawn.x + (Math.random()-0.5) * (Luxe.screen.w * 0.75);
        if(newspawn.x > Luxe.screen.w-20)
        {
            newspawn.x = Luxe.screen.w-20;
        }
        else if(newspawn.x < 20)
        {
            newspawn.x = 20;
        }
        newspawn.y = -10;

        enemy = new Enemy({
            name: 'enemy',
            name_unique: true,
            pos: newspawn,
            color: new Color().rgb(Math.floor(Math.random()*0xffffff)),
            size: new Vector(1,1),
            origin: new Vector(0,0)
        });

        lastspawn.copy_from(newspawn);

    } // spawnEnemy

}