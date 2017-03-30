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
            w: 123
            last_x: 0 # x of last platform
            n : if @gm.gameOptions.fullscreen  then 5 else 8

        @pfm = @gm.add.physicsGroup() # waterlily
        #@pfm.enableBody = true

        @init_pfm()

    #.----------.----------
    # make platforms
    #.----------.----------
    init_pfm:->

        @make_one_pfm(@pm.x0)
        for i in [1..@pm.n - 1] #  n >= 2
            console.log "- #{@_fle_} : ",i
            @make_one_pfm(@pm.last_x + @pm.w)


    make_one_pfm: (x) ->

        p =   @pfm.create x, @pm.y0, "platform"
        @pm.last_x = p.x
        #console.log "- #{@_fle_} : ",@pm.last_x
        p.body.immovable = true

