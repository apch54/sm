###
  written by fc   on 2017 - 03 - 30
###

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

        @dgr = @gm.add.physicsGroup() # make ganger group
        @dgr.enableBody = true
        #console.log "- #{@_fle_} : ",@pm.proba, @gm.parameters

    #.----------.----------
    # make danger : pine trees
    #.----------.----------

    make_danger:(x,y,nd)-> # nd is nb danger

         i = 0
         while nd > i++
            console.log "- #{@_fle_} : ",i,nd
            d = @dgr.create x, y, "danger"
            d.body.immovable = true

         @gm.world.bringToTop @dgr

