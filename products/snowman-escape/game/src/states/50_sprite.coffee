###  written by fc on 2017-03-31  ###

#    ___                _   _         
#   / __|  _ __   _ _  (_) | |_   ___ 
#   \__ \ | '_ \ | '_| | | |  _| / -_)
#   |___/ | .__/ |_|   |_|  \__| \___|
#         |_|                         


class Phacker.Game.Sprite

    constructor: (@gm, @dgrO, @pfmO, @bnsO) ->
        @_fle_ = 'Sprite'

        @pm = @gm.parameters.spt = # parameters
            x0: 50
            y0: @pfmO.pm.y0 - 200
            alt_max: 200    # max altitude sprite can reach
            w: 98           # width of the sprite
            h: 105          # height of the sprite
            vx0: 115        # initial velocity
            dvy: 500        # variation of vy when clicking on jump button
            g : 300         # y gravity
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
            console.log "- #{@_fle_} : ",@pfmO.pm.y0 , @spt.y , @pm.alt_max
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

    #.----------.----------

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

    #.----------.----------

    when_collide_with_dgr:(spt, dgr) ->

        if @pm.has_collided_dgr
            @pm.mess_dgr = 'had loose yet'
            return
        @effO.play dgr
        @pm.mess_dgr = 'loose'
        @pm.has_collided_dgr = true
        @twn_spt_collide()
        return true

    #----------.----------
    # check sprite overlaping bonus : @bnsO
    #----------.----------
    check_bonus: () ->
        ###
        #console.log "- #{@_fle_} : ",@bnsO.bns.getAt(0).x
        bn0 =  @bnsO.bns.getAt(0)
        if -75 < bn0.x - @spt.x < 30
            bn0.fly.start()
            if @spt.y - bn0.y < @bnsO.pm.h
                if not @pm.has_bonus
                    @pm.has_bonus = true;
                    return 'bonus'
                else
                    @pm.has_bonus = true;
                    return 'no bonus'
        ###
        if @bnsO.bns.length < 1 then return
        if @pm.has_bonus then return
        bn0 =  @bnsO.bns.getAt(0)

        bn0_bounds = bn0.getBounds()
        spt_bounds = @spt.getBounds()
        if Phaser.Rectangle.intersects(bn0_bounds, spt_bounds)
            @pm.has_bonus = true
            bn0.fly.start()
            return 'bonus'
    #----------.----------
    # tween effect when collide
    #----------.----------

    twn_spt_collide:()->
        @spt.body.velocity.y = -10
        @spt.body.velocity.x =  0

        @spt.anchor.setTo( .5,.5)
        twn_collide = @gm.add.tween (@spt)
        twn_collide.to(
            { alpha : 0 , angle : 360, y: @spt.y - 100}
            1500, Phaser.Easing.Linear.None
        )
        twn_collide.onComplete.addOnce(
            ->
                @spt.body.velocity.y = -10
                @spt.body.velocity.x =  0
                @spt.anchor.setTo( 0,0)
            @
        )
        twn_collide.start()

    #----------.----------
    # bind sprite whith effectO
    #----------.----------
    bind: (effO) -> @effO =effO

