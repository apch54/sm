
/*    ecrit par fc le  2017-03-29 */

(function() {
  Phacker.Game.Back_ground = (function() {
    function Back_ground(gm) {
      this.gm = gm;
      this._fle_ = 'Back_ground';
      this.pm = this.gm.parameters = {};
      this.posX0 = [-300, -250, -200, -150, -100];
      this.pm.gm = {
        w: this.gm.gameOptions.fullscreen ? 375 : 768,
        h: this.gm.gameOptions.fullscreen ? 559 - 48 : 500 - 48
      };
      this.pm.bg = {
        x0: this.posX0[this.gm.rnd.integerInRange(0, 4)],
        y0: 48,
        w: 768,
        h: 500,
        scaleY: this.gm.gameOptions.fullscreen ? 1 : .85,
        middleX: this.gm.gameOptions.fullscreen ? 187 : 384,
        dvx: .75
      };
      this.pm.btn = {
        w: 200,
        h: 55,
        y0: this.gm.gameOptions.fullscreen ? this.pm.gm.h - 10 : this.pm.gm.h - 18,
        had_tapped: false,
        topCollidePfm: 0
      };
      this.pm.btn.x0 = this.pm.bg.middleX - this.pm.btn.w / 2;
      this.bgs = this.gm.add.physicsGroup();
      this.draw_bgs();
      this.draw_btn();
    }

    Back_ground.prototype.draw_bgs = function() {
      var bg1, bg2, bg3, x2, x3;
      bg1 = this.bgs.create(this.pm.bg.x0, this.pm.bg.y0, 'bg_gameplay');
      bg1.scale.setTo(1, this.pm.bg.scaleY);
      x2 = bg1.x + this.pm.bg.w;
      bg2 = this.bgs.create(x2, this.pm.bg.y0, 'bg_gameplay');
      bg2.scale.setTo(1, this.pm.bg.scaleY);
      x3 = bg2.x + this.pm.bg.w;
      bg3 = this.bgs.create(x2, this.pm.bg.y0, 'bg_gameplay');
      return bg3.scale.setTo(1, this.pm.bg.scaleY);
    };

    Back_ground.prototype.draw_btn = function() {
      this.btn = this.gm.add.button(this.pm.btn.x0, this.pm.btn.y0, 'jump_btn', this.on_tapUp, this, 1, 1, 0);
      this.btn.fixedToCamera = true;
      return this.btn.onInputDown.add(this.on_tapDown, this);
    };

    Back_ground.prototype.on_tapDown = function() {
      if (new Date().getTime() - this.pm.btn.topCollidePfm < 100) {
        return;
      }
      if (this.pm.btn.had_tapped) {
        return;
      }
      this.sptO.spt.body.velocity.y = this.sptO.pm.dvy;
      this.sptO.spt.body.velocity.x = this.sptO.pm.vxlow;
      return this.pm.btn.had_tapped = true;
    };

    Back_ground.prototype.on_tapUp = function() {};

    Back_ground.prototype.bind = function(sptO, pfmO) {
      this.sptO = sptO;
      return this.pfmO = pfmO;
    };

    Back_ground.prototype.create_destroy = function() {
      var bg0, bg3, i, j, ref, x3;
      for (i = j = 0, ref = this.bgs.length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
        this.bgs.getAt(i).x -= this.pm.bg.dvx;
      }
      bg0 = this.bgs.getAt(0);
      if (this.gm.camera.x > bg0.x + this.pm.bg.w) {
        bg0.destroy();
        x3 = this.bgs.getAt(this.bgs.length - 1).x + this.pm.bg.w;
        bg3 = this.bgs.create(x3, this.pm.bg.y0, 'bg_gameplay');
        return bg3.scale.setTo(1, this.pm.bg.scaleY);
      }
    };

    return Back_ground;

  })();

}).call(this);


/*   written by fc   on 2017 - 03 - 30 */

(function() {
  Phacker.Game.Danger = (function() {
    function Danger(gm) {
      this.gm = gm;
      this._fle_ = 'Danger';
      this.pm = this.gm.parameters.dgr = {
        w: 34,
        h: 38,
        proba: 50,
        n: 1,
        dy: 19,
        dx: [10, 20, 30],
        scaleX: .5,
        scaleY: .7
      };
      this.pm.w = this.pm.w * this.pm.scaleX - 3;
      this.dgr = this.gm.add.physicsGroup();
      this.dgr.enableBody = true;
    }

    Danger.prototype.make_danger = function(x, y, nd) {
      var d, i;
      i = 0;
      while (nd > i++) {
        d = this.dgr.create(x, y, "danger");
        d.body.immovable = true;
        d.body.setSize(16, 38, 9, 0);
        d.scale.setTo(this.pm.scaleX, this.pm.scaleY);
        x += this.pm.w + this.gm.gameOptions.danger_space;
      }
      return this.gm.world.bringToTop(this.dgr);
    };

    Danger.prototype.destroy = function() {
      var dg0;
      dg0 = this.dgr.getAt(0);
      if (this.gm.camera.x > dg0.x + this.pm.w) {
        return dg0.destroy;
      }
    };

    Danger.prototype.destroy_dgr_to = function(spt, wx) {
      var dg, i, j, ref;
      for (i = j = 1, ref = this.dgr.length; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
        dg = this.dgr.getAt(0);
        if (dg.x < spt.x + wx) {
          dg.destroy();
        } else {
          return;
        }
      }
    };

    return Danger;

  })();

}).call(this);


/* Written by apch on 02/04/2017 */

(function() {
  Phacker.Game.Bonus = (function() {
    function Bonus(gm) {
      this.gm = gm;
      this._fle_ = 'Bonus';
      this.pm = this.gm.parameters.bns = {
        w: 35,
        h: 47,
        alt: [220, 240, 260]
      };
      this.bns = this.gm.add.physicsGroup();
      this.bns.enableBody = true;
    }

    Bonus.prototype.make_bonus = function(x, y) {
      var bn;
      bn = this.gm.add.sprite(x + 25, y - this.pm.alt[this.gm.rnd.integerInRange(0, 2)], 'bonus_sprite', 2);
      this.anim_bn = bn.animations.add('spk', [0, 1], 5, true);
      bn.animations.play('spk');
      this.bns.add(bn);
      return bn.fly = this.make_twn_fly(bn);
    };

    Bonus.prototype.destroy_to = function(spt, wx) {
      var bn, i, j, ref;
      for (i = j = 1, ref = this.bns.length; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
        bn = this.bns.getAt(0);
        if (bn.x < spt.x + wx) {
          bn.destroy();
        } else {
          return;
        }
      }
    };

    Bonus.prototype.make_twn_fly = function(bn) {
      var fly, x1, y1, yy;
      yy = [-300, +300];
      y1 = yy[this.gm.rnd.integerInRange(0, 1)] + bn.y;
      x1 = bn.x;
      fly = this.gm.add.tween(bn);
      fly.to({
        x: [x1 + 200, x1 + 300],
        y: [bn.y, y1],
        angle: [90, 180]
      }, 700, Phaser.Easing.Linear.None);
      fly.onComplete.add(this.destroy_bonus0, this);
      return fly;
    };

    Bonus.prototype.destroy_bonus0 = function() {
      return this.bns.getAt(0).destroy();
    };

    Bonus.prototype.bind = function(effO) {
      return this.effO = effO;
    };

    return Bonus;

  })();

}).call(this);


/*     ecrit par fc   le  2017-03-30 */

(function() {
  Phacker.Game.Platform = (function() {
    function Platform(gm, dgrO, bnsO) {
      this.gm = gm;
      this.dgrO = dgrO;
      this.bnsO = bnsO;
      this._fle_ = 'Platform';
      this.pm = this.gm.parameters.pfm = {};
      this.pm = {
        x0: -100,
        y0: this.gm.gameOptions.fullscreen ? 460 : 390,
        w: 123,
        h: 34,
        last_x: 0,
        n: this.gm.gameOptions.fullscreen ? 6 : 8
      };
      this.pm.ay0 = [this.pm.y0 + this.pm.h / 2, this.pm.y0, this.pm.y0 - this.pm.h / 2];
      this.pfm = this.gm.add.physicsGroup();
      this.init_pfm();
    }

    Platform.prototype.init_pfm = function() {
      var i, j, nd, ref, results;
      this.make_one_pfm(this.pm.x0, this.pm.y0, 0);
      results = [];
      for (i = j = 1, ref = this.pm.n - 1; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
        if (i === 3 || i === 5) {
          nd = 1;
        } else {
          nd = 0;
        }
        this.make_one_pfm(this.pm.last_x + this.pm.w, this.pm.y0, nd);
        if (i === 4) {
          results.push(this.bnsO.make_bonus(this.pm.last_x + this.pm.w, this.pm.y0));
        } else {
          results.push(void 0);
        }
      }
      return results;
    };

    Platform.prototype.make_one_pfm = function(x, y, nd) {
      var p;
      this.dgrO.make_danger(x, y - this.dgrO.pm.dy, nd);
      p = this.pfm.create(x, y, "platform");
      p.n_danger = nd;
      this.pm.last_x = p.x;
      p.body.immovable = true;
      return p.touched_once = false;
    };

    Platform.prototype.create_destroy = function() {
      var pf0, x3, y_nd_bn;
      pf0 = this.pfm.getAt(0);
      if (this.gm.camera.x > pf0.x + this.pm.w) {
        pf0.destroy();
        y_nd_bn = this.game_rules();
        x3 = this.pfm.getAt(this.pfm.length - 1).x + this.pm.w;
        this.make_one_pfm(x3, y_nd_bn.y, y_nd_bn.nd);
        if (y_nd_bn.bn) {
          return this.bnsO.make_bonus(this.pm.last_x + this.pm.w, this.pm.y0);
        }
      }
    };

    Platform.prototype.game_rules = function() {
      var bns, lastP, lastP1, len, nn, yy;
      len = this.pfm.length;
      lastP = this.pfm.getAt(len - 1);
      if (this.gm.rnd.integerInRange(0, 3) < 1) {
        bns = true;
      } else {
        bns = false;
      }
      if (this.gm.ge.score < 50) {
        nn = this.gm.rnd.integerInRange(0, this.gm.gameOptions.max_dangers);
        yy = lastP.y;
      } else if (this.gm.ge.score < 100) {
        nn = this.gm.rnd.integerInRange(0, this.gm.gameOptions.max_dangers);
        yy = lastP.y;
        this.sptO.pm.vx0 = this.sptO.pm.vx1;
      } else if (this.gm.ge.score < 150) {
        nn = this.gm.rnd.integerInRange(0, this.gm.gameOptions.max_dangers);
        if (len > 2) {
          lastP1 = this.pfm.getAt(len - 2);
        }
        if (lastP.y === lastP1.y) {
          if (lastP.y > this.pm.y0) {
            yy = this.pm.ay0[this.gm.rnd.integerInRange(0, 1)];
          } else if (lastP.y < this.pm.y0) {
            yy = this.pm.ay0[this.gm.rnd.integerInRange(1, 2)];
          } else if (lastP.y === this.pm.y0) {
            yy = this.pm.ay0[this.gm.rnd.integerInRange(0, 2)];
          }
        } else {
          yy = lastP.y;
        }
        this.sptO.pm.vx0 = this.sptO.pm.vx1;
      } else {
        nn = this.gm.rnd.integerInRange(0, this.gm.gameOptions.max_dangers);
        if (len > 2) {
          lastP1 = this.pfm.getAt(len - 2);
        }
        if (lastP.y === lastP1.y) {
          if (lastP.y > this.pm.y0) {
            yy = this.pm.ay0[this.gm.rnd.integerInRange(0, 1)];
          } else if (lastP.y < this.pm.y0) {
            yy = this.pm.ay0[this.gm.rnd.integerInRange(1, 2)];
          } else if (lastP.y === this.pm.y0) {
            yy = this.pm.ay0[this.gm.rnd.integerInRange(0, 2)];
          }
        } else {
          yy = lastP.y;
        }
        this.sptO.pm.vx0 = this.sptO.pm.vx2;
      }
      return {
        y: yy,
        nd: nn,
        bn: bns
      };
    };

    Platform.prototype.bind = function(sptO) {
      return this.sptO = sptO;
    };

    return Platform;

  })();

}).call(this);


/*  written by fc on 2017-03-31 */

(function() {
  Phacker.Game.Sprite = (function() {
    function Sprite(gm, dgrO, pfmO, bnsO) {
      this.gm = gm;
      this.dgrO = dgrO;
      this.pfmO = pfmO;
      this.bnsO = bnsO;
      this._fle_ = 'Sprite';
      this.pm = this.gm.parameters.spt = {
        x0: 50,
        y0: this.pfmO.pm.y0 - 200,
        alt_max: 267 * this.gm.gameOptions.altmax_percent,
        w: 98,
        h: 105,
        vx0: this.gm.gameOptions.spriteVx0,
        vx1: this.gm.gameOptions.spriteVx0 * this.gm.gameOptions.ratio_vx0,
        vx2: this.gm.gameOptions.spriteVx0 * this.gm.gameOptions.ratio_vx0 * this.gm.gameOptions.ratio_vx0,
        vxlow: 40,
        vyTop: this.gm.gameOptions.spriteVyTop,
        vyLow: this.gm.gameOptions.spriteVyLow,
        dvy: 600,
        g: 300,
        mess_pfm: "nothing yet",
        mess_dgr: "no danger yet",
        has_collided: false,
        has_collided_dgr: false,
        has_bonus: false
      };
      this.spt = this.gm.add.sprite(this.pm.x0, this.pm.y0, 'character_sprite');
      this.gm.physics.arcade.enable(this.spt, Phaser.Physics.ARCADE);
      this.spt.body.setSize(42, 102, 38, 3);
      this.spt.body.bounce.y = 1;
      this.spt.body.gravity.y = this.pm.g;
      this.spt.body.velocity.x = this.pm.vx0;
      this.anim_spt = this.spt.animations.add('jmp', [0, 1, 2, 3, 2, 1, 0], 15, false);
    }

    Sprite.prototype.collide_with_pfm = function() {
      if ((this.pfmO.pm.y0 - this.spt.y) > this.pm.alt_max) {
        this.spt.body.velocity.y = this.pm.vyTop;
        this.spt.body.velocity.x = this.pm.vx0;
        this.gm.parameters.btn.had_tapped = false;
        this.spt.y += 3;
      }
      if (this.gm.physics.arcade.collide(this.spt, this.pfmO.pfm, function() {
        return true;
      }, function(spt, pfm) {
        return this.when_collide_with_pfm(spt, pfm);
      }, this)) {
        return this.pm.mess_pfm;
      }
      return 'nothing';
    };

    Sprite.prototype.when_collide_with_pfm = function(spt, pfm) {
      this.gm.parameters.btn.topCollidePfm = new Date().getTime();
      this.pm.has_bonus = false;
      spt.body.velocity.x = this.pm.vx0;
      spt.body.velocity.y = this.pm.vyLow;
      spt.animations.play('jmp');
      if (!pfm.touched_once && !this.pm.has_collided_dgr) {
        this.pm.mess_pfm = 'win';
      } else {
        this.pm.mess_pfm = 'touched once';
      }
      pfm.touched_once = true;
      return true;
    };

    Sprite.prototype.collide_with_dgr = function() {
      if (this.gm.physics.arcade.collide(this.spt, this.dgrO.dgr, function() {
        return true;
      }, function(spt, dgr) {
        return this.when_collide_with_dgr(spt, dgr);
      }, this)) {
        return this.pm.mess_dgr;
      }
      return 'nothing';
    };

    Sprite.prototype.when_collide_with_dgr = function(spt, dgr) {
      if (this.pm.has_collided_dgr) {
        this.pm.mess_dgr = 'had loose yet';
        return;
      }
      this.effO.play(dgr);
      this.pm.mess_dgr = 'loose';
      this.pm.has_collided_dgr = true;
      this.twn_spt_collide();
      return true;
    };

    Sprite.prototype.check_bonus = function() {
      var bn0, bn0_bounds, ref, spt_bounds;
      if (this.bnsO.bns.length < 1) {
        return;
      }
      if (this.pm.has_bonus) {
        return;
      }
      bn0 = this.bnsO.bns.getAt(0);
      bn0_bounds = bn0.getBounds();
      spt_bounds = this.spt.getBounds();
      if (Phaser.Rectangle.intersects(bn0_bounds, spt_bounds)) {
        this.pm.has_bonus = true;
        this.effO.bonus(bn0.x, bn0.y);
        bn0.destroy();
        return 'bonus';
      } else if ((-75 < (ref = bn0.x - this.spt.x) && ref < 30)) {
        return bn0.destroy();
      }
    };

    Sprite.prototype.twn_spt_collide = function() {
      var twn_collide;
      this.spt.body.velocity.y = -10;
      this.spt.body.velocity.x = 0;
      this.spt.anchor.setTo(.5, .5);
      twn_collide = this.gm.add.tween(this.spt);
      twn_collide.to({
        alpha: 0,
        angle: 360,
        y: this.spt.y + 300
      }, 1500, Phaser.Easing.Linear.None);
      twn_collide.onComplete.addOnce(function() {
        this.spt.y = this.pm.y0;
        this.spt.body.velocity.y = -10;
        this.spt.body.velocity.x = 0;
        return this.spt.anchor.setTo(0, 0);
      }, this);
      return twn_collide.start();
    };

    Sprite.prototype.bind = function(effO) {
      return this.effO = effO;
    };

    return Sprite;

  })();

}).call(this);


/*  ecrit par fc le 2017-03-31 */

(function() {
  Phacker.Game.My_camera = (function() {
    function My_camera(gm) {
      this.gm = gm;
      this._fle_ = 'Camera';
      this.pm = this.gm.parameters.cam = {};
      this.pm = {
        offset: this.gm.gameOptions.fullscreen ? 60 : 100,
        speed: 5
      };
    }

    My_camera.prototype.move = function(spt) {
      if ((this.gm.camera.x - spt.x + this.pm.offset) < -this.pm.speed) {
        return this.gm.camera.x += this.pm.speed;
      } else {
        return this.gm.camera.x = spt.x - this.pm.offset;
      }
    };

    return My_camera;

  })();

}).call(this);

(function() {
  Phacker.Game.Effects = (function() {
    function Effects(gm) {
      this.gm = gm;
      this._fle_ = 'Effect';
      this.effects = ['effect1', 'effect3', 'effect2'];
    }

    Effects.prototype.play = function(obj) {
      var anim, n;
      if (this.eff != null) {
        this.eff.destroy();
      }
      n = this.gm.gameOptions.color_effect ? this.gm.rnd.integerInRange(1, 1) : this.gm.rnd.integerInRange(0, 1);
      this.eff = this.gm.add.sprite(50, 100, this.effects[n], 2);
      if (this.gm.gameOptions.color_effect) {
        this.eff.tint = Math.random() * 0xffffff;
      }
      this.eff.anchor.setTo(0.5, 0.5);
      anim = this.eff.animations.add('explode', [2, 1, 0, 1, 2, 1, 0, 1, 2], 8, false);
      anim.onComplete.add(function() {
        return this.eff.destroy();
      }, this);
      this.eff.x = obj.x;
      this.eff.y = obj.y;
      return this.eff.animations.play('explode');
    };

    Effects.prototype.bonus = function(x, y) {
      var anim, n;
      n = this.gm.rnd.integerInRange(1, 1);
      this.eff = this.gm.add.sprite(50, 100, this.effects[n], 2);
      this.eff.anchor.setTo(0.5, 0.5);
      anim = this.eff.animations.add('explode', [2, 1, 0, 1], 8, false);
      anim.onComplete.add(function() {
        return this.eff.destroy();
      }, this);
      this.eff.x = x;
      this.eff.y = y;
      return this.eff.animations.play('explode');
    };

    Effects.prototype.stop = function() {
      return this.eff.destroy();
    };

    return Effects;

  })();

}).call(this);


/* written by fc on 2017-04-01 */

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.YourGame = (function(superClass) {
    extend(YourGame, superClass);

    function YourGame() {
      return YourGame.__super__.constructor.apply(this, arguments);
    }

    YourGame.prototype.update = function() {
      var resp1, resp3;
      YourGame.__super__.update.call(this);
      this._fle_ = 'jeu Update';
      if ((resp1 = this.spriteO.check_bonus()) === 'bonus') {
        this.winBonus();
      }
      if (this.spriteO.collide_with_pfm() === 'win') {
        this.win();
      }
      if ((resp3 = this.spriteO.collide_with_dgr()) === 'loose') {
        this.lostLife();
      }
      this.cameraO.move(this.spriteO.spt);
      this.bgO.create_destroy();
      this.platformO.create_destroy();
      return this.dangerO.destroy(this.spriteO.spt);
    };

    YourGame.prototype.resetPlayer = function() {
      this.spriteO.pm.has_collided_dgr = false;
      this.spriteO.pm.has_bonus = false;
      this.spriteO.spt.alpha = 1;
      this.dangerO.destroy_dgr_to(this.spriteO.spt, 200);
      return this.bonusO.destroy_to(this.spriteO.spt, 200);
    };

    YourGame.prototype.create = function() {
      YourGame.__super__.create.call(this);
      this.game.physics.startSystem(Phaser.Physics.ARCADE);
      this.game.world.setBounds(-1000, -1000, 300000, 2000);
      this.bgO = new Phacker.Game.Back_ground(this.game);
      this.dangerO = new Phacker.Game.Danger(this.game);
      this.bonusO = new Phacker.Game.Bonus(this.game);
      this.platformO = new Phacker.Game.Platform(this.game, this.dangerO, this.bonusO);
      this.spriteO = new Phacker.Game.Sprite(this.game, this.dangerO, this.platformO, this.bonusO);
      this.bgO.bind(this.spriteO, this.platformO);
      this.platformO.bind(this.spriteO);
      this.cameraO = new Phacker.Game.My_camera(this.game);
      this.effectO = new Phacker.Game.Effects(this.game);
      this.spriteO.bind(this.effectO);
      return this.bonusO.bind(this.effectO);
    };

    return YourGame;

  })(Phacker.GameState);

}).call(this);
