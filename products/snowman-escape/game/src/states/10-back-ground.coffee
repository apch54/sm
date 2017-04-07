###    ecrit par fc le  2017-03-29    ###


#    ___               _                                         _ 
#   | _ )  __ _   __  | |__  __ _   _ _   ___   _  _   _ _    __| |
#   | _ \ / _` | / _| | / / / _` | | '_| / _ \ | || | | ' \  / _` |
#   |___/ \__,_| \__| |_\_\ \__, | |_|   \___/  \_,_| |_||_| \__,_|
#                           |___/                                  



class Phacker.Game.Back_ground

    constructor: (@gm) ->
        @_fle_ = 'Back_ground'
        @pm = @gm.parameters = {}
        @posX0 = [-300, -250, -200, -150, -100] # init_pos

        @pm.gm =
            w:  if @gm.gameOptions.fullscreen  then 375 else 768
            h:  if @gm.gameOptions.fullscreen  then 559 - 48 else 500 - 48

        @pm.bg = # global parameters for back_ground
            x0: @posX0[@gm.rnd.integerInRange(0, 4)]
            y0: 48
            w: 768
            h: 500
            scaleY: if @gm.gameOptions.fullscreen  then 1 else .85
            middleX: if @gm.gameOptions.fullscreen  then 187 else 384

        @pm.btn = # global parameters for jump button
            w: 200
            h: 55
            y0: if @gm.gameOptions.fullscreen then @pm.gm.h + 5  else @pm.gm.h - 18
            had_tapped: false
            topCollidePfm : 0 # top collision pfm against sprite
        @pm.btn.x0 = @pm.bg.middleX - @pm.btn.w / 2

        @bgs =  @gm.add.physicsGroup() # make background group # store backgrounds

        @draw_bgs() # draw 3 backgrounds
        @draw_btn()

      #.----------.----------
      # build background
      #.----------.----------

    draw_bgs: ->
        bg1 =  @bgs.create @pm.bg.x0, @pm.bg.y0, 'bg_gameplay' # 768x500
        bg1.scale.setTo(1, @pm.bg.scaleY)

        x2 = bg1.x + @pm.bg.w
        bg2 =  @bgs.create x2, @pm.bg.y0, 'bg_gameplay' # 768x500
        bg2.scale.setTo(1, @pm.bg.scaleY)

        x3 = bg2.x + @pm.bg.w
        bg3 = @bgs.create x2, @pm.bg.y0, 'bg_gameplay' # 768x500
        bg3.scale.setTo(1, @pm.bg.scaleY)


    #.----------.----------
    # button
    #.----------.----------
    draw_btn: ->
        @btn = @gm.add.button @pm.btn.x0, @pm.btn.y0, 'jump_btn', @on_tapUp, @, 1, 1, 0
        @btn.fixedToCamera = true
        @btn.onInputDown.add @on_tapDown, @

    on_tapDown:() ->
        # avoid double bounce
        if new Date().getTime()- @pm.btn.topCollidePfm   < 100 then return
        if @pm.btn.had_tapped then return
        @sptO.spt.body.velocity.y = @sptO.pm.dvy
        @sptO.spt.body.velocity.x = @sptO.pm.vxlow
        @pm.btn.had_tapped = true
        #console.log "- #{@_fle_} : ", '--- im in on tap ---'

    on_tapUp: -> return # do nothing

    #.----------.----------
    # bind to sprite and plateform
    #.----------.----------
    bind:(sptO, pfmO) ->

        @sptO = sptO
        @pfmO = pfmO
        #console.log "- #{@_fle_} : ",sptO, pfmO

    #.----------.---------- 
    #  rolling in platform
    #.----------.----------
    create_destroy:() ->
        bg0 = @bgs.getAt(0)
        #console.log "- #{@_fle_} : ",@sptO.spt.x - @pm.bg.w ,  bg0.x

        #if @sptO.spt.x - @pm.bg.w  >=  bg0.x + 500
        if @gm.camera.x > bg0.x + @pm.bg.w
            bg0.destroy()

            x3 = @bgs.getAt(@bgs.length - 1).x  + @pm.bg.w
            bg3 =  @bgs.create x3, @pm.bg.y0, 'bg_gameplay' # 768x500
            bg3.scale.setTo(1, @pm.bg.scaleY)




