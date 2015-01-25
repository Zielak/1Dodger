package;

import Enemy;

import luxe.Input;
import luxe.Vector;

import phoenix.BitmapFont;
import phoenix.Batcher;
import phoenix.Color;
import phoenix.geometry.TextGeometry;


class Main extends luxe.Game
{

    var playing:Bool;



    var bounds:Vector;


    var player:Player;
    var ground:Ground;
    var spawner:Spawner;

    var score:Int;


    override function config(config:luxe.AppConfig):luxe.AppConfig
    {
        config.window.width = 400;
        config.window.height = 600;
        config.window.resizable = false;
                
        return config;
    }

    override function ready()
    {

        initGame();
        play();
        Luxe.events.listen('enemy.damaged', function(e:EnemyEvent){
            if(!playing) return;
            if(e.enemy.collider.hit == false) return;
            score += pointsDamage;
            updateScoreText();
        });

        Luxe.events.listen('enemy.destroyed', function(e:EnemyEvent){
            if(!playing) return;
            if(e.enemy.collider.hit == false) return;
            score += pointsDestroy;
            updateScoreText();
        });

    } //ready

    override function onkeyup( e:KeyEvent )
    {

        if(e.keycode == Key.escape && !playing)
        {
            quit2();
        }
        else if(e.keycode == Key.escape && playing)
        {
            quit1();
        }

        if(e.keycode == Key.enter && !playing)
        {
            play();
        }

    } //onkeyup

    override function update(dt:Float)
    {
        
    } //update



    function initGame():Void
    {
        var _w:Float = Luxe.screen.w/Luxe.camera.zoom;
        var _h:Float = Luxe.screen.w/Luxe.camera.zoom;

        bounds = new Vector(_w, _h);
        trace('bounds: ${bounds}');

        player = new Player({
            name: 'player',
            pos: Luxe.camera.screen_point_to_world( new Vector(Luxe.screen.w/2, Luxe.screen.h - 30) ),
            size: new Vector(20,20),
            color: new Color().rgb(0x00ff00)
        });

        ground = new Ground({
            name: 'ground',
            pos: Luxe.camera.screen_point_to_world( new Vector(Luxe.screen.w/2, Luxe.screen.h - 10) ),
            size: new Vector(bounds.x, 20),
            color: new Color().rgb(0x663366),
            centered: true
        });

        spawner = new Spawner({
            name: 'spawner'
        });
        
        playing = true;
    }




    function quit1():Void
    {
        playing = false;
        spawner.stopSpawning();
    } // quit1

    function quit2():Void
    {
        Luxe.shutdown();   
    } // quit2

    function play():Void
    {
        playing = true;
        spawner.startSpawning();

    } // play



} //Main
