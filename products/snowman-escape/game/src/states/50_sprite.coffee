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
            alt_max: 200  # max altitude sprite can reach
            w: 98           # width of the sprite
            h: 105          # height of the sprite
            vx0: @gm.gameOptions.vx0    # initial velocity
            vx1: @gm.gameOptions.vx1         # snow man vx variation for acceleration
            vx2: @gm.gameOptions.vx2
            vxlow: 40       # low vi when bouncing
            vyTop:@gm.gameOptions.vyTop
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
        #@spt.body.velocity.y = @pm.dvy

        @anim_spt = @spt.animations.add 'jmp', [0, 1, 2, 3, 2, 1, 0 ], 15, false
        #@spt.animations.play('jmp')

#        @bns = @gm.add.sprite 500,200 , 'bonus_sprite'
#        @gm.physics.arcade.enable @bns,Phaser.Physics.ARCADE
#        @bns.body.velocity.x = @pm.vx0
#        walk = @bns.animations.add('walk')
#        @bns.animations.play 'walk', 30, true
    #.----------.----------
    # collide sprite with platform
    #.----------.----------
    collide_with_pfm: () ->

        # is sprite over alt max ?
        if (@pfmO.pm.y0 - @spt.y) > @pm.alt_max
            @spt.body.velocity.y = @pm.vyTop
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
        if not pfm.touched_once  and not @pm.has_collided_dgr then @pm.mess_pfm = 'win'
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

        if @bnsO.bns.length < 1 then return
        if @pm.has_bonus then return
        bn0 =  @bnsO.bns.getAt(0)

        bn0_bounds = bn0.getBounds()
        spt_bounds = @spt.getBounds()
        if Phaser.Rectangle.intersects(bn0_bounds, spt_bounds)
            @pm.has_bonus = true
            #bn0.fly.start()
            @effO.bonus bn0.x, bn0.y
            bn0.destroy()
            return 'bonus'

        # fly away and destroy if not overlaping
        else if -75 < bn0.x - @spt.x < 30 then bn0.destroy() #bn0.fly.start()

    #----------.----------
    # tween effect when collide with danger
    #----------.----------

    twn_spt_collide:()->
        @spt.body.velocity.y = -10
        @spt.body.velocity.x =  0

        @spt.anchor.setTo( .5,.5)
        twn_collide = @gm.add.tween (@spt)
        twn_collide.to(
            { alpha : 0 , angle : 360, y: @spt.y + 300}
            1500, Phaser.Easing.Linear.None
        )
        twn_collide.onComplete.addOnce(
            ->
                @spt.y = @pm.y0
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

