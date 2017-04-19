# fc : 2017-02-06


class Phacker.Game.Effects

    constructor:(@gm) ->
        @_fle_      ='Effect'
        @effects = ['effect1','effect3','effect2']

    #.----------.----------
    # play animation & stop when collide with platform
    #.----------.----------

    play:(obj) ->#
        @eff. destroy() if @eff?
        n =  if @gm.gameOptions.color_effect then @gm.rnd.integerInRange(1, 1) else @gm.rnd.integerInRange(0, 1) # choose animation

        @eff= @gm.add.sprite 50, 100, @effects[n] ,2 #86x88 & create effect
        @eff.tint = Math.random() * 0xffffff if @gm.gameOptions.color_effect
        @eff.anchor.setTo(0.5, 0.5) # anchor in the middle of bottom
        anim = @eff.animations.add  'explode', [2, 1, 0, 1, 2, 1, 0, 1, 2 ], 8, false
        anim.onComplete.add(
            ()-> @eff.destroy()
            @
        )
        @eff.x = obj.x   #set effect location
        @eff.y = obj.y
        @eff.animations.play 'explode'

    #.----------.----------
    # effect when bonus collide
    # .----------.----------

    bonus:(x,y) ->#
        #@eff.destroy() if @eff?
        #console.log "- #{@_fle_} : ", 'I m in effect'
        n = @gm.rnd.integerInRange 1, 1 # choose animation

        @eff= @gm.add.sprite 50, 100, @effects[n] ,2 #86x88 & create effect
        #@eff.tint = Math.random() * 0xffffff
        @eff.anchor.setTo(0.5, 0.5) # anchor in the middle of bottom
        anim = @eff.animations.add  'explode', [2, 1, 0, 1], 8, false
        anim.onComplete.add(
            ()-> @eff.destroy()
            @
        )
        @eff.x =  x   #set effect location
        @eff.y =  y

        @eff.animations.play 'explode'

    stop: -> @eff.destroy()



