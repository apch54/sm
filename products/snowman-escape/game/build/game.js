
/*
  ----------.----------
      ecrit par fc
      le  2017-03-29
  ----------.----------
 */

(function() {
  Phacker.Game.Back_ground = (function() {
    function Back_ground(gm) {
      this.gm = gm;
      this._fle_ = 'Back_ground';
      this.pm = this.gm.parameters = {};
      this.posX0 = [-400, -300, -200, -100, 0];
      this.pm.gm = {
        w: this.gm.gameOptions.fullscreen ? 375 : 768,
        h: this.gm.gameOptions.fullscreen ? 559 - 48 : 500 - 48
      };
      this.pm.bg = {
        x0: this.posX0[this.gm.rnd.integerInRange(0, 4)],
        y0: 48,
        w: 768,
        h: 500,
        middleX: this.gm.gameOptions.fullscreen ? 187 : 384
      };
      this.pm.btn = {
        w: 200,
        h: 55,
        y0: this.gm.gameOptions.fullscreen ? this.pm.gm.h + 5 : this.pm.gm.h - 12
      };
      this.pm.btn.x0 = this.pm.bg.middleX - this.pm.btn.w / 2;
      this.bgs = [];
      this.draw_bgs();
      this.draw_btn();
    }

    Back_ground.prototype.draw_bgs = function() {
      var x2, x3;
      this.bg1 = this.gm.add.sprite(this.pm.bg.x0, this.pm.bg.y0, 'bg_gameplay');
      this.bgs.push(this.bg1);
      x2 = this.bg1.x + this.pm.bg.w;
      this.bg2 = this.gm.add.sprite(x2, this.pm.bg.y0, 'bg_gameplay');
      this.bgs.push(this.bg2);
      x3 = this.bg2.x + this.pm.bg.w;
      this.bg3 = this.gm.add.sprite(x3, this.pm.bg.y0, 'bg_gameplay');
      return this.bgs.push(this.bg3);
    };

    Back_ground.prototype.draw_btn = function() {
      this.btn = this.gm.add.button(this.pm.btn.x0, this.pm.btn.y0, 'jump_btn', this.on_tap, this, 1, 1, 0);
      return this.btn.fixedToCamera = true;
    };

    Back_ground.prototype.on_tap = function() {
      return console.log("- " + this._fle_ + " : ", '--- im in on tap ---');
    };

    return Back_ground;

  })();

}).call(this);


/*
  written by fc   on 2017 - 03 - 30
 */

(function() {
  Phacker.Game.Danger = (function() {
    function Danger(gm) {
      this.gm = gm;
      this._fle_ = 'Danger';
      this.pm = this.gm.parameters.dgr = {};
      this.pm = {
        w: 34,
        h: 38,
        proba: 50,
        n: 1
      };
      this.dgr = this.gm.add.physicsGroup();
      this.dgr.enableBody = true;
    }

    Danger.prototype.make_danger = function(x, y, nd) {
      var d, i;
      i = 0;
      while (nd > i++) {
        console.log("- " + this._fle_ + " : ", i, nd);
        d = this.dgr.create(x, y, "danger");
        d.body.immovable = true;
      }
      return this.gm.world.bringToTop(this.dgr);
    };

    return Danger;

  })();

}).call(this);


/*
      ecrit par fc   le  2017-03-30
 */

(function() {
  Phacker.Game.Platform = (function() {
    function Platform(gm, dgrO) {
      this.gm = gm;
      this.dgrO = dgrO;
      this._fle_ = 'Platform';
      this.gm.parameters.scl = {};
      this.pm = this.gm.parameters.pfm;
      this.pm = {
        x0: 0,
        y0: this.gm.gameOptions.fullscreen ? 460 : 400,
        w: 123,
        h: 34,
        dy_danger: 29,
        last_x: 0,
        n: this.gm.gameOptions.fullscreen ? 6 : 8
      };
      this.pfm = this.gm.add.physicsGroup();
      this.init_pfm();
    }

    Platform.prototype.init_pfm = function() {
      var i, j, nd, ref, results;
      this.make_one_pfm(this.pm.x0, this.pm.y0, 0);
      results = [];
      for (i = j = 1, ref = this.pm.n - 1; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
        if (i === 2 || i === 5) {
          nd = 1;
        } else {
          nd = 0;
        }
        results.push(this.make_one_pfm(this.pm.last_x + this.pm.w, this.pm.y0, nd));
      }
      return results;
    };

    Platform.prototype.make_one_pfm = function(x, y, nd) {
      var p;
      this.dgrO.make_danger(x, y - this.pm.dy_danger, nd);
      p = this.pfm.create(x, y, "platform");
      this.pm.last_x = p.x;
      return p.body.immovable = true;
    };

    return Platform;

  })();

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.YourGame = (function(superClass) {
    extend(YourGame, superClass);

    function YourGame() {
      return YourGame.__super__.constructor.apply(this, arguments);
    }

    YourGame.prototype.update = function() {
      return YourGame.__super__.update.call(this);
    };

    YourGame.prototype.resetPlayer = function() {
      return console.log("Reset the player");
    };

    YourGame.prototype.create = function() {
      var bonusBtn, lostBtn, lostLifeBtn, winBtn;
      YourGame.__super__.create.call(this);
      this.game.physics.startSystem(Phaser.Physics.ARCADE);
      this.game.world.setBounds(-1000, -1000, 300000, 2000);
      this.bgO = new Phacker.Game.Back_ground(this.game);
      this.dangerO = new Phacker.Game.Danger(this.game);
      this.platformO = new Phacker.Game.Platform(this.game, this.dangerO);
      lostBtn = this.game.add.text(0, 0, "Bad Action");
      lostBtn.inputEnabled = true;
      lostBtn.y = this.game.height * 0.5 - lostBtn.height * 0.5;
      lostBtn.events.onInputDown.add((function() {
        return this.lost();
      }).bind(this));
      winBtn = this.game.add.text(0, 0, "Good Action");
      winBtn.inputEnabled = true;
      winBtn.y = this.game.height * 0.5 - winBtn.height * 0.5;
      winBtn.x = this.game.width - winBtn.width;
      winBtn.events.onInputDown.add((function() {
        return this.win();
      }).bind(this));
      lostLifeBtn = this.game.add.text(0, 0, "Lost Life");
      lostLifeBtn.inputEnabled = true;
      lostLifeBtn.y = this.game.height * 0.5 - lostLifeBtn.height * 0.5;
      lostLifeBtn.x = this.game.width * 0.5 - lostLifeBtn.width * 0.5;
      lostLifeBtn.events.onInputDown.add((function() {
        return this.lostLife();
      }).bind(this));
      bonusBtn = this.game.add.text(0, 0, "Bonus");
      bonusBtn.inputEnabled = true;
      bonusBtn.y = this.game.height * 0.5 - bonusBtn.height * 0.5 + 50;
      bonusBtn.x = this.game.width - bonusBtn.width;
      bonusBtn.events.onInputDown.add((function() {
        return this.winBonus();
      }).bind(this));
      if (this.game.gameOptions.fullscreen) {
        lostBtn.x = this.game.width * 0.5 - lostBtn.width * 0.5;
        lostBtn.y = this.game.height * 0.25;
        winBtn.x = this.game.width * 0.5 - winBtn.width * 0.5;
        winBtn.y = this.game.height * 0.5;
        lostLifeBtn.x = this.game.width * 0.5 - lostLifeBtn.width * 0.5;
        lostLifeBtn.y = this.game.height * 0.75;
        bonusBtn.x = this.game.width * 0.5 - winBtn.width * 0.5;
        return bonusBtn.y = this.game.height * 0.5 + 50;
      }
    };

    return YourGame;

  })(Phacker.GameState);

}).call(this);
