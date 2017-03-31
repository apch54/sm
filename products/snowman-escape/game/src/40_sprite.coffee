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
            message: "nothing yet"

        @spt = @gm.add.sprite 100, 200  , 'character_sprite', 0 # 95 x 102
        @gm.physics.arcade.enable @spt,Phaser.Physics.ARCADE
        @spt.body.setSize(42, 102, 38, 3) # w, h, offset x, offset y
        @spt.body.gravity.y = 200

    #.----------.----------
    # collide sprite with platform
    #.----------.----------
    collide: () ->
        if @gm.physics.arcade.collide(
          @spt, @pfmO.pfm
          -> return true
          (spt, pfm)-> @when_collide(spt, pfm)
          @
        ) then return @pm.message
        return 'nothing'

    when_collide:(spt, pfm) -> console.log "- #{@_fle_} : ",'i\'m in when collide'


