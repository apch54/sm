### written by fc on 2017-04-01 ###

#             ___
#           _[___]_  _       |---------------|
#            ( " )  [_]   << | hi every body |
#        '--(`~:~`)--|'      |---------------|
#          / `-:-' \ |
#     __.--\   :   /--.


class @YourGame extends Phacker.GameState

		update: ->
				super() #Required

				@spriteO.collide_with_pfm()
				@cameraO.move @spriteO.spt


		resetPlayer: ->
				console.log "Reset the player"

		create: ->
				super() #Required

				@game.physics.startSystem(Phaser.Physics.ARCADE)
				@game.world.setBounds(-1000, -1000, 300000,  2000) # offset x, offset y, w, h

				@bgO = new Phacker.Game.Back_ground @game
				@dangerO = new Phacker.Game.Danger @game
				@platformO = new Phacker.Game.Platform @game , @dangerO

				@spriteO = new Phacker.Game.Sprite @game , @dangerO, @platformO
				@bgO.bind @spriteO, @platformO

				@cameraO = new Phacker.Game.My_camera @game





				##### LOGIC OF YOUR GAME #####
				# Examples buttons actions
				#
				lostBtn = @game.add.text(0, 0, "Bad Action");
				lostBtn.inputEnabled = true;
				lostBtn.y = @game.height*0.5 - lostBtn.height*0.5
				lostBtn.events.onInputDown.add ( ->
					@lost()
				).bind @

				winBtn = @game.add.text(0, 0, "Good Action");
				winBtn.inputEnabled = true;
				winBtn.y = @game.height*0.5 - winBtn.height*0.5
				winBtn.x = @game.width - winBtn.width
				winBtn.events.onInputDown.add ( ->
					@win()
				).bind @

				lostLifeBtn = @game.add.text(0, 0, "Lost Life");
				lostLifeBtn.inputEnabled = true;
				lostLifeBtn.y = @game.height*0.5 - lostLifeBtn.height*0.5
				lostLifeBtn.x = @game.width*0.5 - lostLifeBtn.width*0.5
				lostLifeBtn.events.onInputDown.add ( ->
					@lostLife()
				).bind @

				bonusBtn = @game.add.text(0, 0, "Bonus");
				bonusBtn.inputEnabled = true;
				bonusBtn.y = @game.height*0.5 - bonusBtn.height*0.5 + 50
				bonusBtn.x = @game.width - bonusBtn.width
				bonusBtn.events.onInputDown.add ( ->
					@winBonus()
				).bind @

				#Placement specific for mobile

				if @game.gameOptions.fullscreen
					lostBtn.x = @game.width*0.5 - lostBtn.width*0.5
					lostBtn.y = @game.height*0.25

					winBtn.x = @game.width*0.5 - winBtn.width*0.5
					winBtn.y = @game.height*0.5

					lostLifeBtn.x = @game.width*0.5 - lostLifeBtn.width*0.5
					lostLifeBtn.y = @game.height*0.75

					bonusBtn.x = @game.width*0.5 - winBtn.width*0.5
					bonusBtn.y = @game.height*0.5 + 50


