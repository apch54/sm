### * Created by apch on 02/04/2017 * ###

#       iiiiiiiiii
#     |:H:a:p:p:y:|
#   __|___________|__
#  |^^^^^^^^^^^^^^^^^|
#  |:B:i:r:t:h:d:a:y:|
#  | eric & clem     |
#  ------------------

class Phacker.Game.Bonus

   constructor: (@gm) ->
       @_fle_ = 'Back_ground'

       @pm = @gm.parameters.bns =
          w: 35
          h: 47

       @bns = @gm.add.physicsGroup() # make bonus group
       @bns.enableBody = true