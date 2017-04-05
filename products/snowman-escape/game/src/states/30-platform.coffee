###     ecrit par fc   le  2017-03-30   ###

class Phacker.Game.Platform

    constructor: (@gm, @dgrO, @bnsO) ->
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
            @make_one_pfm @pm.last_x + @pm.w, @pm.y0, nd

            if i is 3 then @bnsO.make_bonus @pm.last_x + @pm.w, @pm.y0

    #.----------.----------
    # make one pfm
    #.----------.----------

    make_one_pfm: (x,y,nd) -> # nd stands for danger nb
        @dgrO.make_danger(x + @dgrO.pm.dx, y - @dgrO.pm.dy, nd)

        p =   @pfm.create x, y, "platform"
        p.n_danger = nd
        @pm.last_x = p.x
        p.body.immovable = true
        p.touched_once = false

    #----------.----------
    # create_destroy platforms
    #----------.----------
    create_destroy: () ->

        pf0 = @pfm.getAt(0)

        #if @sptO.spt.x - @pm.w - 200  >=  pf0.x
        if  @gm.camera.x > pf0.x + @pm.w
            pf0.destroy()

            y_nd_bn = @game_rules() # y_nd_bn = {y: ..., nd : nb of danger, bn: bonus yes or no}
            #console.log "- #{@_fle_} : ",y_nd_bn
            x3 = @pfm.getAt(@pfm.length - 1).x  + @pm.w
            @make_one_pfm(x3, y_nd_bn.y, y_nd_bn.nd)

            if y_nd_bn.bn then @bnsO.make_bonus @pm.last_x + @pm.w, @pm.y0

    #----------.----------
    # game rules
    #----------.----------
    game_rules:->
        lastP =  @pfm.getAt(@pfm.length - 1) # last pfm
        if lastP.n_danger > 0 then nn = 0
        else nn = @gm.rnd.integerInRange(1, 3)

        yy = lastP.y

        if @gm.rnd.integerInRange(0, 2) < 1 then bns = yes else bns = no
        return {y: yy, nd: nn, bn: bns}

    #----------.----------
    # bindd to spriteO
    #----------.----------
    bind:(sptO) ->
        @sptO = sptO
        #@bnsO = bnsO




