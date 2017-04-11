### written by fc on 2017-04-01 ###

#             ___
#           _[___]_  _       | --------------- |
#            (.. )  [_]   << | hi rico & clem  |
#        '--(`~:~`)--|'      | --------------- |
#          / `-:-' \ |
#   ____.--\   :   /--.____
#   _______________________

class @YourGame extends Phacker.GameState

    update: ->
        super() #Required
        @_fle_ = 'jeu Update'

        # bounce with platform & chech bonus
        if (resp1 = @spriteO.check_bonus()) is 'bonus'
            @winBonus()
            #console.log "- #{@_fle_} : ",'bonus'

        if @spriteO.collide_with_pfm()  is  'win' then   @win()

        if (resp3 = @spriteO.collide_with_dgr()) is 'loose' # test collision with danger
           @lostLife()  #console.log "- #{@_fle_} : ",'loose'

        @cameraO.move @spriteO.spt
        @bgO.create_destroy()
        @platformO.create_destroy()
        @dangerO.destroy @spriteO.spt


    resetPlayer: ->
        @spriteO.pm.has_collided_dgr = false
        @spriteO.pm.has_bonus = false
        #@spriteO.spt.y -= 100
        @spriteO.spt.alpha  = 1
        @dangerO.destroy_dgr_to @spriteO.spt, 200 # destroy danger from spt.x to spt.x + wx
        @bonusO.destroy_to @spriteO.spt, 200 # destroy danger from spt.x to spt.x + wx



    create: ->
        super() #Required

        @game.physics.startSystem(Phaser.Physics.ARCADE)
        @game.world.setBounds(-1000, -1000, 300000, 2000) # offset x, offset y, w, h

        @bgO = new Phacker.Game.Back_ground @game
        @dangerO = new Phacker.Game.Danger @game
        @bonusO = new Phacker.Game.Bonus @game
        @platformO = new Phacker.Game.Platform @game, @dangerO, @bonusO


        @spriteO = new Phacker.Game.Sprite @game, @dangerO, @platformO, @bonusO
        @bgO.bind @spriteO, @platformO
        @platformO.bind @spriteO #, bonusO

        @cameraO = new Phacker.Game.My_camera @game

        @effectO = new Phacker.Game.Effects @game
        @spriteO.bind @effectO
        @bonusO.bind @effectO


