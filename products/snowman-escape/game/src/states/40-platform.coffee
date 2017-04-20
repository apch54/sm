###     ecrit par fc   le  2017-03-30   ###

#    ___   _          _            __                     
#   | _ \ | |  __ _  | |_   ___   / _|  ___   _ _   _ __  
#   |  _/ | | / _` | |  _| / -_) |  _| / _ \ | '_| | '  \ 
#   |_|   |_| \__,_|  \__| \___| |_|   \___/ |_|   |_|_|_|
                                                        

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
        # platform altidude variation
        @pm.ay0 = [@pm.y0 + @pm.h / 2, @pm.y0, @pm.y0 - @pm.h / 2]

        @pfm = @gm.add.physicsGroup() # waterlily
        #@pfm.enableBody = true

        @init_pfm()

    #.----------.----------
    # make platforms
    #.----------.----------

    init_pfm:->

        @make_one_pfm(@pm.x0, @pm.y0, 0)
        for i in [1..@pm.n - 1] #  @pm.n #must be# >= 2

            if i in [3,5]  then nd = 1 else nd = 0 # danger nb
            @make_one_pfm @pm.last_x + @pm.w, @pm.y0, nd

            if i is 4 then @bnsO.make_bonus @pm.last_x + @pm.w, @pm.y0

    #.----------.----------
    # make one pfm
    #.----------.----------

    make_one_pfm: (x,y,nd) -> # nd stands for danger nb
        @dgrO.make_danger(x , y - @dgrO.pm.dy, nd)

        p =   @pfm.create x, y, "platform"
        p.n_danger = nd # nb danger in platform
        @pm.last_x = p.x
        p.body.immovable = true
        p.touched_once = false # spt mark one if touch on a platform

    #----------.----------
    # create_destroy platforms
    #----------.----------
    create_destroy: () ->

        pf0 = @pfm.getAt(0)

        if  @gm.camera.x > pf0.x + @pm.w
            pf0.destroy()

            y_nd_bn = @game_rules() # y_nd_bn = {y: ..., nd : nb of danger, bn: bonus yes or no}
            x3 = @pfm.getAt(@pfm.length - 1).x  + @pm.w
            @make_one_pfm(x3, y_nd_bn.y, y_nd_bn.nd)

            if y_nd_bn.bn then @bnsO.make_bonus @pm.last_x + @pm.w, @pm.y0

    #----------.----------
    # game rules
    #----------.----------
    game_rules:->

        # danger
        len = @pfm.length
        lastP =  @pfm.getAt(len - 1) # last plateform

        # bonus
        if @gm.rnd.integerInRange(0, 3) < 1 then bns = yes else bns = no

        # 1st rule ----------.----------
        if @gm.ge.score < 50
            #if lastP.n_danger > 1 then nn = @gm.rnd.integerInRange(0, 1)
            nn = @gm.rnd.integerInRange(0, @gm.gameOptions.max_dangers)
            yy = lastP.y # vertical location ##

        # 2nd rule ----------.---------.
        else if @gm.ge.score < 100
            nn = @gm.rnd.integerInRange(0, @gm.gameOptions.max_dangers)
            yy = lastP.y # vertical location ##
            @sptO.pm.vx0 = @sptO.pm.vx1
            #console.log @sptO.pm.vx1


        # 3rd rule ----------.----------.
        else if @gm.ge.score < 150
            nn = @gm.rnd.integerInRange(0, @gm.gameOptions.max_dangers)

            if len > 2 then lastP1 =  @pfm.getAt(len - 2) # last -1  pfm2
            # change platform alt pfm only if 2 platforms have the same hight
            if lastP.y is lastP1.y
                if  lastP.y > @pm.y0        then yy = @pm.ay0[@gm.rnd.integerInRange(0,1)]
                else if  lastP.y < @pm.y0   then yy = @pm.ay0[@gm.rnd.integerInRange(1,2)]
                else if lastP.y is @pm.y0   then yy = @pm.ay0[@gm.rnd.integerInRange(0,2)]
            else yy = lastP.y

            @sptO.pm.vx0 = @sptO.pm.vx1

        # 4th rule ----------.----------.
        #speed variation
        else
            nn = @gm.rnd.integerInRange(0, @gm.gameOptions.max_dangers)

            if len > 2 then lastP1 =  @pfm.getAt(len - 2) # last -1  pfm2
            # change platform alt pfm only if 2 platforms have the same hight
            if lastP.y is lastP1.y
                if  lastP.y > @pm.y0        then yy = @pm.ay0[@gm.rnd.integerInRange(0,1)]
                else if  lastP.y < @pm.y0   then yy = @pm.ay0[@gm.rnd.integerInRange(1,2)]
                else if lastP.y is @pm.y0   then yy = @pm.ay0[@gm.rnd.integerInRange(0,2)]
            else yy = lastP.y

            @sptO.pm.vx0 = @sptO.pm.vx2

        #return info rule to make platform
        return {y: yy, nd: nn, bn: bns}

    #----------.----------
    # bind to spriteO
    #----------.----------
    bind:(sptO) ->
        @sptO = sptO
        #@bnsO = bnsO




