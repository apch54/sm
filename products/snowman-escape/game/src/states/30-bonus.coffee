### Written by apch on 02/04/2017 ###

#       iiiiiiiiii
#     |:H:a:p:p:y:|
#   __|___________|__
#  |^^^^^^^^^^^^^^^^^|
#  |:B:i:r:t:h:d:a:y:|
#  | eric & clem     |
#  ------------------

class Phacker.Game.Bonus

   constructor: (@gm) ->
       @_fle_ = 'Bonus'

       @pm = @gm.parameters.bns =
            w: 35
            h: 47
            alt:  [220,240,260] #@gm.parameters.spt.alt_max

       @bns = @gm.add.physicsGroup() # make bonus group
       @bns.enableBody = true

    #----------.----------
    # create & init bonus
    #----------.----------
   make_bonus: (x,y) ->

        bn = @gm.add.sprite x + 25, y - @pm.alt[@gm.rnd.integerInRange(0,2)] , 'bonus_sprite'  # 95 x 102
        #@anim_bn = bn.animations.add 'spk', [0, 1], 5, true
        #bn.frame = 1
        #bn.animations.play('spk')

        #console.log "- #{@_fle_} :", bn.animations
        #bn.body.immovable = true
        @bns.add bn #; console.log "- #{@_fle_} : ",@bns
        bn.fly = @make_twn_fly(bn)

    #----------.----------
    # destroy all bonus
    # from spt.x to bns.x + wx (in pixel)
    #----------.----------
   destroy_to:(spt, wx)->

        for i in  [1..@bns.length]
            bn = @bns.getAt(0)
            if bn.x < spt.x + wx then bn.destroy()
            else return

   #.----------.----------
   # no used any more
   # make tween  : bonus fly
   # tween is @fly
   #.----------.----------
   make_twn_fly:(bn) -> #no more used

        yy =[ -300, +300] # 2 y way to escape bonus"
        y1 = yy[@gm.rnd.integerInRange(0,1 )] + bn.y
        x1 = bn.x
        fly = @gm.add.tween (bn)
        fly.to(
            { x: [x1 + 200, x1 + 300 ],  y:[bn.y, y1] , angle : [90, 180]}
            700, Phaser.Easing.Linear.None
        )
        fly.onComplete.add( @destroy_bonus0, @)
        return fly

   #----------.----------
   # destroy the first alive bonus
   #----------.----------
   destroy_bonus0: ->   @bns.getAt(0).destroy()

   #----------.----------
   # bind with effect
   bind: (effO) ->   @effO =effO


