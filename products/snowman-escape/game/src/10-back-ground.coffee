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

      @pm.bg = # global parameter"
          x0: @posX0[@gm.rnd.integerInRange(0, 4)]
          y0: 48 # background
          w: 768
          h: 500
          middleX: if @gm.gameOptions.fullscreen  then 187 else 384

      @bgs = [] # store backgrounds

      @draw_bgs()

  #.----------.----------
  # build socle
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
      console.log "- #{@_fle_} : ",@bgs[0].x,  @bgs[1].x, @bgs[2].x
      #@bg.fixedToCamera = true



