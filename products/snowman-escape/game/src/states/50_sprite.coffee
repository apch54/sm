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
            mess_pfm: "nothing yet" # collide message
            mess_dgr: "no danger yet"
            has_collided : false
            has_collided_dgr : false
            has_bonus : false

        @spt = @gm.add.sprite @pm.x0, @pm.y0  , 'character_sprite'  # 95 x 102
        @gm.physics.arcade.enable @spt,Phaser.Physics.ARCADE
        @spt.body.setSize(42, 102, 38, 3) # w, h, offset x, offset y
        @spt.body.bounce.y = 1.2
        @spt.body.gravity.y = @pm.g
        @spt.body.velocity.x = @pm.vx0

        @anim_spt = @spt.animations.add 'jmp', [0, 1, 2, 1, 3, 0, ], 15, false
        #@spt.animations.play('jmp')


    #.----------.----------
    # collide sprite with platform
    #.----------.----------
    collide_with_pfm: () ->

        # is sprite over alt max ?
        if (@pfmO.pm.y0 - @spt.y) > @pm.alt_max
            @spt.body.velocity.y = 10
            @spt.body.velocity.x = @pm.vx0
            @gm.parameters.btn.had_tapped = false
            @spt.y += 3

        if @gm.physics.arcade.collide(
            @spt, @pfmO.pfm
            -> return true
            (spt, pfm)-> @when_collide_with_pfm(spt, pfm)
            @
        ) then return @pm.mess_pfm
        return 'nothing'

    when_collide_with_pfm:(spt, pfm) ->
        #console.log "- #{@_fle_} :", pfm.key
        @gm.parameters.btn.topCollidePfm = new Date().getTime()
        @pm.has_bonus = false
        spt.body.velocity.x = @pm.vx0
        spt.animations.play 'jmp'

        # sprite cannot mark twice or more on the same platform
        if not pfm.touched_once  then @pm.mess_pfm = 'win'
        else  @pm.mess_pfm = 'touched once'
        pfm.touched_once = true
        return true

    #.----------.----------
    # collide with dangers : @dgr
    #.----------.----------
    collide_with_dgr:->

        if @gm.physics.arcade.collide(
            @spt, @dgrO.dgr
            -> return true
            (spt, dgr)-> @when_collide_with_dgr(spt, dgr)
            @
        ) then return @pm.mess_dgr
        return 'nothing'

    when_collide_with_dgr:(spt, dgr) ->

        if @pm.has_collided_dgr
            @pm.mess_dgr = 'had loose yet'
            return

        #console.log "- #{@_fle_} : ",'in loose'
        @pm.mess_dgr = 'loose'
        @pm.has_collided_dgr= true
        return true

    #----------.----------
    # check sprite overlaping bonus
    #----------.----------
    check_bonus: () ->

        #console.log "- #{@_fle_} : ",@bnsO.bns.getAt(0).x
        bn0 =  @bnsO.bns.getAt(0)
        if 0 < bn0.x - @spt.x < 30
            bn0.fly.start()
            if @spt.y - bn0.y < @bnsO.pm.h
                if not @pm.has_bonus
                    @pm.has_bonus = true;
                    return 'bonus'
                else
                    @pm.has_bonus = true;
                    return 'no bonus'

