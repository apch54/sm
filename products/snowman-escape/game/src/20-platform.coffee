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
            x0: 20
            y0: if @gm.gameOptions.fullscreen  then 470 else 410
            w: 128
            last_x: 0 # x of last platform
            n : 7 # platform nb

        @pfm = @gm.add.physicsGroup() # waterlily
        #@pfm.enableBody = true

        @init_pfm()

    #.----------.----------
    # make platforms
    #.----------.----------
    init_pfm:->

        @make_one_pfm(@pm.x0)
        for i in [1, @pm.n - 1] #  n >= 2
            @make_one_pfm(@pm.last_x + @pm.w)


    make_one_pfm: (x) ->

        p =   @pfm.create x, @pm.y0, "platform"
        @pm.last_x = p.x
        console.log "- #{@_fle_} : ",@pm.last_x
        p.body.immovable = true

