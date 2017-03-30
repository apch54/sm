###
  ----------.----------
      ecrit par fc
      le  2017-03-29
  ----------.----------
###


class Phacker.Game.Back_ground

      constructor: (@gm) ->
          @_fle_ = 'Back_ground'
          @pm = @gm.parameters = {}
          @posX0 = [-400, -300, -200, -100, 0] # init_pos

          @pm.gm =
              w:  if @gm.gameOptions.fullscreen  then 375 else 768
              h:  if @gm.gameOptions.fullscreen  then 559 - 48 else 500 - 48

          @pm.bg = # global parameters for back_ground
              x0: @posX0[@gm.rnd.integerInRange(0, 4)]
              y0: 48
              w: 768
              h: 500
              middleX: if @gm.gameOptions.fullscreen  then 187 else 384

          @pm.btn = # global parameters for jump button
              w: 200
              h: 55
              y0: if @gm.gameOptions.fullscreen then @pm.gm.h + 5  else @pm.gm.h - 12
          @pm.btn.x0 = @pm.bg.middleX - @pm.btn.w / 2

          @bgs = [] # store backgrounds

          @draw_bgs()
          @draw_btn()

      #.----------.----------
      # build background
      #.----------.----------

      draw_bgs: ->

          @bg1 = @gm.add.sprite @pm.bg.x0, @pm.bg.y0, 'bg_gameplay' # 768x500
          @bgs.push @bg1

          x2 = @bg1.x + @pm.bg.w
          @bg2 = @gm.add.sprite x2, @pm.bg.y0, 'bg_gameplay' # 768x500
          @bgs.push @bg2

          x3 = @bg2.x + @pm.bg.w
          @bg3 = @gm.add.sprite x3, @pm.bg.y0, 'bg_gameplay' # 768x500
          @bgs.push @bg3
          #console.log "- #{@_fle_} : ",@bgs[0].x,  @bgs[1].x, @bgs[2].x
          #@bg.fixedToCamera = true

      #.----------.----------
      # button
      #.----------.----------
      draw_btn: ->

           @btn = @gm.add.button @pm.btn.x0, @pm.btn.y0, 'jump_btn', @on_tap, @, 1, 1, 0
           @btn.fixedToCamera = true

      on_tap: ->

          console.log "- #{@_fle_} : ", '--- im in on tap ---'



