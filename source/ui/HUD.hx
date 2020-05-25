package ui;

import entities.*;
import flixel.util.FlxTimer;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class HUD extends FlxTypedGroup<FlxSprite> {
	var background:FlxSprite;
	var backgroundHeight:Int;
	var backgroundColor:FlxColor;

	var dividerHeight:Int;
	var dividerColor:FlxColor;

	var text:FlxText;

	var healthBar:FlxBar;
	var barWidth:Int;

	var player:Player;
	var actors:FlxTypedGroup<Mover>;

	var nOfInfected:Int;

	var refreshTimer:FlxTimer;

	public function new(_player:Player/*, _actors:FlxTypedGroup<Mover>*/) {
		super();

		player = _player;

		backgroundHeight = 40;
		backgroundColor = FlxColor.ORANGE;
		dividerHeight = 2;
		dividerColor = FlxColor.YELLOW;

		background = new FlxSprite(0, FlxG.height - backgroundHeight);
		background.makeGraphic(FlxG.width, backgroundHeight, backgroundColor);
		FlxSpriteUtil.drawRect(background, 0, 0, FlxG.width, dividerHeight, dividerColor);
		add(background);

		text = new FlxText((FlxG.width / 2), background.y + 5, 0, "HP: 30 / 30", 25);
		text.setPosition(text.x - (text.width / 2), text.y);
		text.setBorderStyle(SHADOW, FlxColor.BLACK, 1);
		add(text);

		// we call the function on each element, by setting scrollFactor to 0,0 the elements won't scroll based on camera movements
		forEach(function(el:FlxSprite) {
			el.scrollFactor.set(0, 0);
		});

		/// HUD REFRESH TIMER
		refreshTimer = new FlxTimer();
		refreshTimer.start(0.2, function(_) {
			updateHUD();
		}, 0);
	}

	public function updateHUD() {
		text.text = 'rotation velocity: ${player.body.rotational_velocity}';
	}
}
