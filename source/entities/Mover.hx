package entities;

import flixel.util.FlxColor;
import echo.Body;
import hxmath.math.Vector2;
import flixel.FlxSprite;

using utilities.FlxEcho;

class Mover extends FlxSprite {
	/// CONTROL FLAGS
	var canMove:Bool = false;
	var forwardPressed:Bool = false;
	var backwardPressed:Bool = false;
	var leftPressed:Bool = false;
	var rightPressed:Bool = false;

	///
	var speed:Int;

	/// BODY
	public var body(default, null):Body;

	public function new() {
		super();
	}

	public function init(_x:Float, _y:Float, _width:Int, _height:Int, _color:FlxColor, _canMove = true) {
		width = _width;
		height = _height;
		this.add_body({mass: 1});
		body = this.get_body();
		speed = 250;
		body.max_velocity_length = 1000;
		body.max_rotational_velocity = 150;
		body.rotational_drag = 50;
		body.x = _x;
		body.y = _y;
		makeGraphic(_width, _height, _color);
		canMove = _canMove;
	}

	override function update(elapsed:Float) {
		updateMovement();

		super.update(elapsed);
	}

	function updateMovement() {
		if (canMove) {
			if (forwardPressed || backwardPressed || leftPressed || rightPressed) {
				if (leftPressed) {
					body.push(-speed);
				}
				if (rightPressed) {
					body.push(speed);
				}
				if (forwardPressed) {
					body.push(0, -speed);
				}
				if (backwardPressed) {
					body.push(0, speed);
				}

				/*
					if (forwardPressed && leftPressed) {
						body.rotation = 225;
					}
					if (forwardPressed && rightPressed) {
						body.rotation = 315;
					}
					if (backwardPressed && leftPressed) {
						body.rotation = 135;
					}
					if (backwardPressed && rightPressed) {
						body.rotation = 45;
					}
				 */
			}
		}
	}
}
