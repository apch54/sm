###   written by fc   on 2017 - 03 - 30 ###

#    ___                                   
#   |   \   __ _   _ _    __ _   ___   _ _ 
#   | |) | / _` | | ' \  / _` | / -_) | '_|
#   |___/  \__,_| |_||_| \__, | \___| |_|  
#                        |___/             

class Phacker.Game.Danger

    constructor: (@gm) ->
        @_fle_ = 'Danger'

        @pm = @gm.parameters.dgr =
            w: 34
            h: 38
            proba : 50 # 50%
            n: 1 # nuber max of danger on each platform
            dy: 19  # relative danger obj location against platform
            dx: [10, 20, 30] # offset  danger.x against platform.x
            scaleX: .5
            scaleY: .7
        @pm.w = @pm.w * @pm.scaleX - 3

        @dgr = @gm.add.physicsGroup() # make danger group
        @dgr.enableBody = true

    #.----------.----------
    # make danger : pine trees
    #.----------.----------

    make_danger:(x,y,nd)-> # nd is nb danger

         i = 0
         ddx=@pm.dx[@gm.rnd.integerInRange(0,2)]

         while nd > i++
            d = @dgr.create x + ddx, y, "danger"
            d.body.immovable = true
            d.body.setSize(16, 38, 9, 0) # w, h, offset x, offset y
            d.scale.setTo @pm.scaleX, @pm.scaleY

            x += @pm.w

         @gm.world.bringToTop @dgr

    #----------.----------
    # create_destroy danger pines
    #----------.----------
    destroy: () ->
        dg0 = @dgr.getAt(0)
        #if spt.x - @pm.w - 200>=  dg0.x  then dg0.destroy()
        if @gm.camera.x >dg0.x + @pm.w then dg0.destroy

    #----------.----------
    # destroy all danger pines on the same platform
    # from spt.x to spt.x + wx
    #----------.----------

    destroy_dgr_to:(spt, wx)->

        for i in  [1..@dgr.length]
            dg = @dgr.getAt(0)
            if dg.x < spt.x + wx then dg.destroy()
            else return



