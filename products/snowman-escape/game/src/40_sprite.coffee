###  written by fc on 2017-03-31  ###
class Phacker.Game.Sprite

    constructor: (@gm, @dgrO, @pfmO) ->
        @_fle_ = 'Sprite'
        @pm = @gm.parameters.spt = {}

        @pm =
            x0: 50
            y0: @pfmO.pm.y0 - 200
            alt_max: 200 # max altitude sprite can reach
            w: 98  # width of the sprite
            h: 105 # height of the sprite
            dvy: 500 # variation of vy when clicking on jump button
            g : 500
            message: "nothing yet" # collide message
            has_collided : false

        @spt = @gm.add.sprite @pm.x0, @pm.y0  , 'character_sprite'  # 95 x 102
        @gm.physics.arcade.enable @spt,Phaser.Physics.ARCADE
        @spt.body.setSize(42, 102, 38, 3) # w, h, offset x, offset y
        @spt.body.bounce.y = 1.2
        @anim_spt = @spt.animations.add 'jmp', [0, 1, 2, 1, 3], 8, false
        #@spt.animations.play('jmp')
        @spt.body.gravity.y = @pm.g

    #.----------.----------
    # collide sprite with platform
    #.----------.----------
    collide_with_pfm: () ->

        if (@pfmO.pm.y0 - @spt.y) > @pm.alt_max
            @spt.body.velocity.y = 10
            @spt.y += 5
        if @gm.physics.arcade.collide(
            @spt, @pfmO.pfm
            -> return true
            (spt, pfm)-> #@when_collide_with_pfm(spt, pfm)
                #@pm.message = 'bouncing'
                @spt.animations.play 'jmp'
            @
        ) then return @pm.message
        return 'nothing'

    when_collide_with_pfm:(spt, pfm) ->
        #console.log "- #{@_fle_} :", pfm.key


