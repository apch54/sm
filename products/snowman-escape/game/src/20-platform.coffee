###
  ----------.----------
      ecrit par fc
      le  2017-03-30
  ----------.----------
###

class Phacker.Game.Platform

    constructor: (@gm) ->
        @_fle_ = 'Platform'
        @gm.parameters.scl = {}
        @pm = @gm.parameters.pfm
        @pm =
            x0: 0
            y0: if @gm.gameOptions.fullscreen  then 470 else 410
            last_x: 0

        @pfm = @gm.add.physicsGroup() # waterlily
        #@pfm.enableBody = true

        @make_one_pfm()

    make_one_pfm: ->
        p =   @pfm.create @pm.x0, @pm.y0, "platform"
        p.body.immovable = true

