###     ecrit par fc   le  2017-03-30   ###

class Phacker.Game.Platform

    constructor: (@gm, @dgrO) ->
        @_fle_ = 'Platform'
        @pm = @gm.parameters.pfm = {}
        @pm = # platform parameters
            x0: -100
            y0: if @gm.gameOptions.fullscreen  then 460 else 390
            w: 123
            h: 34
            last_x: 0 # x of last platform
            n : if @gm.gameOptions.fullscreen  then 6 else 8

        @pfm = @gm.add.physicsGroup() # waterlily
        #@pfm.enableBody = true

        @init_pfm()

    #.----------.----------
    # make platforms
    #.----------.----------

    init_pfm:->

        @make_one_pfm(@pm.x0, @pm.y0, 0)
        for i in [1..@pm.n - 1] #  @pm.n #must be# >= 2

            if i in [2, 5] then nd = 1 else nd = 0 # danger nb
            @make_one_pfm(@pm.last_x + @pm.w, @pm.y0, nd)

    #.----------.----------
    # make one pfm
    #.----------.----------

    make_one_pfm: (x,y,nd) -> # nd stands for danger nb

        @dgrO.make_danger(x + @dgrO.pm.dx, y - @dgrO.pm.dy, nd)

        p =   @pfm.create x, y, "platform"
        @pm.last_x = p.x
        p.body.immovable = true

    #----------.----------
    # create_destroy platforms
    #----------.----------
    create_destroy: () ->



