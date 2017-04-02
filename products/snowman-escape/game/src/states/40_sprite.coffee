###  written by fc on 2017-03-31  ###
class Phacker.Game.Sprite

    constructor: (@gm, @dgrO, @pfmO, @bnsO) ->
        @_fle_ = 'Sprite'

        @pm = @gm.parameters.spt =
            x0: 50
            y0: @pfmO.pm.y0 - 200
            alt_max: 200 # max altitude sprite can reach
            w: 98  # width of the sprite
            h: 105 # height of the sprite
            vx0: 115
            dvy: 500 # variation of vy when clicking on jump button
            g : 300
            message: "nothing yet" # collide message
            has_collided : false

        @spt = @gm.add.sprite @pm.x0, @pm.y0  , 'character_sprite'  # 95 x 102
        @gm.physics.arcade.enable @spt,Phaser.Physics.ARCADE
        @spt.body.setSize(42, 102, 38, 3) # w, h, offset x, offset y
        @spt.body.bounce.y = 1.2
        @spt.body.gravity.y = @pm.g
        @spt.body.velocity.x = @pm.vx0

        @anim_spt = @spt.animations.add 'jmp', [0, 1, 2, 1, 3], 8, false
        #@spt.animations.play('jmp')


    #.----------.----------
    # collide sprite with platform
    #.----------.----------
    collide_with_pfm: () ->

        if (@pfmO.pm.y0 - @spt.y) > @pm.alt_max
            @spt.body.velocity.y = 10
            @spt.body.velocity.x = @pm.vx0
            @gm.parameters.btn.had_tapped = false
            @spt.y += 3

        if @gm.physics.arcade.collide(
            @spt, @pfmO.pfm
            -> return true
            (spt, pfm)-> #@when_collide_with_pfm(spt, pfm)
                @gm.parameters.btn.topCollidePfm = new Date().getTime()
                @spt.body.velocity.x = @pm.vx0
                @spt.animations.play 'jmp'
                return true
            @
        ) then return @pm.message
        return 'nothing'

    when_collide_with_pfm:(spt, pfm) ->
        #console.log "- #{@_fle_} :", pfm.key


