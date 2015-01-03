
package components;

import luxe.Component;
import luxe.Input;

class Input extends Component
{

    public var left:Bool    = false;
    public var right:Bool   = false;
    public var fire:Bool    = false;

    public var move:Bool    = false;

    override function init():Void
    {
        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('right', Key.right);

        Luxe.input.bind_key('fire', Key.space);
    }

    override function update(dt:Float):Void
    {
        updateKeys();
    }


    function updateKeys():Void
    {
        left  = Luxe.input.inputdown('left');
        right = Luxe.input.inputdown('right');

        fire  = Luxe.input.inputdown('fire');

        if(left && right)
        {
            left = right = move = false;
        }
        else
        {
            move = true;
        }
    }


}
