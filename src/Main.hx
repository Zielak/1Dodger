package;

import Enemy;

import luxe.Input;
import luxe.Rectangle;
import luxe.Text;
import luxe.Vector;
import phoenix.Batcher;
import phoenix.BitmapFont;
import phoenix.Color;


class Main extends luxe.Game
{

    var playing:Bool;



    var bounds:Vector;


    var player:Player;
    var ground:Ground;
    var spawner:Spawner;

    var score:Int;
    var pointsDamage:Int = 2;
    var pointsDestroy:Int = 10;

    var welcomeText:Text;
    var scoreText:Text;


    override function config(config:luxe.AppConfig):luxe.AppConfig
    {
        config.window.width = 400;
        config.window.height = 600;
        config.window.resizable = false;
                
        return config;
    }

    override function ready()
    {
        playing = false;
        initGame();

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


        welcomeText = new Text({
            bounds: new Rectangle(0,100,Luxe.screen.w, 100),
            align: center,
            point_size: 16,
            text: 'Press ENTER to start\nARROWS + SPACE',
            batcher: Luxe.renderer.batcher
        });
        
        scoreText = new Text({
            bounds: new Rectangle(10, 10, Luxe.screen.w-10, 30),
            align: left,
            point_size: 24,
            text: 'SCORE: 0',
        });
        scoreText.visible = false;
        score = 0;

        playing = false;
    }



    function updateScoreText():Void
    {
        scoreText.text = 'SCORE: ${score}';
    }




    function quit1():Void
    {
        playing = false;

        welcomeText.visible = true;
        scoreText.visible = false;

        spawner.stopSpawning();
    } // quit1

    function quit2():Void
    {
        Luxe.shutdown();   
    } // quit2

    function play():Void
    {
        playing = true;

        welcomeText.visible = false;
        score = 0;
        updateScoreText();
        scoreText.visible = true;

        spawner.startSpawning();

    } // play



} //Main
