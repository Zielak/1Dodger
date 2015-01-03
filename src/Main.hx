
import luxe.Input;

import phoenix.Color;
import phoenix.Vector;

class Main extends luxe.Game
{


    var bounds:Vector;


    var player:Player;
    var ground:Ground;

    override function config(config:luxe.AppConfig):luxe.AppConfig
    {
        config.window.width = 400;
        config.window.height = 400;
        config.window.resizable = false;
                
        return config;
    }

    override function ready()
    {
        Luxe.camera.zoom = 2;
        

        initGame();

    } //ready

    override function onkeyup( e:KeyEvent )
    {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
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

        player = new Player({
            name: 'player',
            pos: Luxe.camera.screen_point_to_world( new Vector(Luxe.screen.w/2, Luxe.screen.h - 30) ),
            size: new Vector(10,10),
            color: new Color().rgb(0x00ff00)
        });

        ground = new Ground({
            name: 'ground',
            pos: Luxe.camera.screen_point_to_world( new Vector(Luxe.screen.w/2, Luxe.screen.h - 10) ),
            size: new Vector(bounds.x, 5),
            color: new Color().rgb(0x663366),
            centered: true
        });
        
    }

} //Main
