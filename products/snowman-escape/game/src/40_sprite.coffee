###
  written by fc on 2017-03-31
###
class Phacker.Game.Sprite

    constructor: (@gm, @dgrO, @pfmO) ->
        @_fle_ = 'Sprite'
        @pm = @gm.parameters.spt = {}

        @pm =
            x0: 200
            y0: if @gm.gameOptions.fullscreen  then 200 else 390
            w: 98
            h: 105
            message: "nothing yet" # collide message
            has_collided : false

        @spt = @gm.add.sprite 100, 200  , 'character_sprite'  # 95 x 102
        @gm.physics.arcade.enable @spt,Phaser.Physics.ARCADE
        @spt.body.setSize(42, 102, 38, 3) # w, h, offset x, offset y
        @anim_spt = @spt.animations.add 'jmp', [0, 1, 2, 1, 3], 8, true
        @spt.animations.play('jmp')
        @spt.body.gravity.y = 200

    #.----------.----------
    # collide sprite with platform
    #.----------.----------
    collide_with_pfm: () ->
        if @gm.physics.arcade.collide(
            @spt, @pfmO.pfm
            -> return true
            (spt, pfm)-> @when_collide_with_pfm(spt, pfm)
            @
        ) then return @pm.message
        return 'nothing'

    when_collide_with_pfm:(spt, pfm) ->
        console.log "- #{@_fle_} :", pfm.key


