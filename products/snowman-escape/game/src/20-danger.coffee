###   written by fc   on 2017 - 03 - 30 ###

class Phacker.Game.Danger

    constructor: (@gm) ->
        @_fle_ = 'Danger'
        @pm = @gm.parameters.dgr = {}
        #@pm = @gm.parameters.dgr
        @pm =
            w: 34
            h: 38
            proba : 50 # 50%
            n: 1 # nuber max of danger on each platform
            dy: 24  # relative danger obj location against platform
            dx: 10 # offset  danger.x against platform.x

        @dgr = @gm.add.physicsGroup() # make ganger group
        @dgr.enableBody = true

    #.----------.----------
    # make danger : pine trees
    #.----------.----------

    make_danger:(x,y,nd)-> # nd is nb danger

         i = 0
         while nd > i++
            d = @dgr.create x, y, "danger"
            d.body.immovable = true
            x += @pm.w

         @gm.world.bringToTop @dgr

    #----------.----------
    # create_destroy danger pines
    #----------.----------
    destroy: (spt) ->
        dg0 = @dgr.getAt(0)
        if spt.x - @pm.w - 200>=  dg0.x  then dg0.destroy()

