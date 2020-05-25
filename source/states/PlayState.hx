package states;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import entities.*;
import ui.*;
import tiles.*;
import flixel.FlxState;

using utilities.FlxEcho;

class PlayState extends FlxState {
	var movers:FlxGroup;
	var terrainTiles:FlxGroup;

	var player:Player;

	var level_data = [
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
		[1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], [1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], [1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
		[1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	];

	override public function create() {
		/// CREATING GROUPS
		terrainTiles = new FlxGroup();
		add(terrainTiles);
		movers = new FlxGroup();
		add(movers);

		/// CREATING WORLD
		FlxEcho.init({ // First thing we want to do before creating any physics objects is init() our Echo world
			width: level_data[0].length * 16, // Make the size of your Echo world equal the size of your play field
			height: level_data.length * 16,
			// gravity_y: 200
		});

		/// CREATING LEVEL
		for (j in 0...level_data.length) { // We'll step through our level data and add objects that way
			for (i in 0...level_data[j].length) {
				switch (level_data[j][i]) {
					case 1:
						// Just a regular old terrain block
						var tile = new Tile();
						tile.add_body({mass: 0});
						tile.init(i * 16, j * 16, 16, 16);
						tile.add_to_group(terrainTiles);

					case 3:
						player = new Player();
						player.add_body({mass: 1});
						player.init(i * 16, j * 16, 8, 12, FlxColor.ORANGE);
						player.add_to_group(movers);

					default:
						continue;
				}
			}
		}

		/// ADDING COLLISION LISTENERS
		movers.listen(terrainTiles); // why do I not get collisions?
		player.listen(terrainTiles);
		player.listen(movers);

		/// CREATING HUD
		var hud = new HUD(player);
		add(hud);

		/// SETTING UP CAMERA
		FlxG.camera.follow(player, FlxCameraFollowStyle.LOCKON);

		super.create();
	}

	override public function update(elapsed:Float) {
		FlxEcho.update(elapsed); // Make sure to call `FlxEcho.update()` before `super.update()`!
		super.update(elapsed);

		// create clones, test out collisions between moving objects
		if (FlxG.keys.anyJustReleased([Q])) {
			var player1 = new Player();
			player1.init(player.x, player.y - 50, Std.int(player.width), Std.int(player.height), FlxColor.RED);
			player1.body.rotation = player.body.rotation;
			player1.add_to_group(movers);
		}
	}
}
