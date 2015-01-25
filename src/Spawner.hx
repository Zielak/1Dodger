
package ;

import luxe.Entity;
import luxe.Vector;

import phoenix.Color;

class Spawner extends Entity
{
    var spawning:Bool = false;

    var cd:Float;
    var cooldown:Float;
    static inline var maxcooldown:Float = 3;
    static inline var mincooldown:Float = 0.6;

    var enemyCount:Int = 0;
        // Totally randomize position after X enemies
    var randomizeNewSpawn:Int = 8;

    var enemy:Enemy;

    var newspawn:Vector;
    var lastspawn:Vector;

    override public function init():Void
    {
        lastspawn = new Vector(Luxe.screen.w/2, -10);
        newspawn = new Vector().copy_from(lastspawn);
        
        spawning = true;
    }


    override function update(dt:Float):Void
    {
        updateTimers(dt);
    }



    public function startSpawning():Void
    {
        spawning = true;
        cd = 0;
        cooldown = maxcooldown;
    }

    public function stopSpawning():Void
    {
        spawning = false;
        cooldown = maxcooldown;
        cd = maxcooldown;
    }






    function updateTimers(dt:Float):Void
    {
        if(!spawning) return;


        cd -= dt;
        if(cd < 0)
        {
            cd = 0;
        }
        if(cd == 0)
        {
            spawnEnemy();
        }
    } // updateTimers


    function spawnEnemy():Void
    {
        cd = cooldown;
        if(cooldown > mincooldown)
        {
            cooldown = cooldown * .99;
        }

        enemyCount++;

        newspawn = new Vector();
        // Totally randomize spawn point after some time
        // Avoid "stucking" to the wall
        if(enemyCount % randomizeNewSpawn == 0)
        {
            newspawn.x = Luxe.screen.w/2 * Math.random() + Luxe.screen.w/4;
        }
        else
        {
            newspawn.x = lastspawn.x + (Math.random()-0.5) * (Luxe.screen.w * 0.75);
        }
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