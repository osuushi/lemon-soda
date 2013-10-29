(function() {
  var addRule, defer, getJSON, sheet, style, styleRoot, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.LemonSoda = new ((function() {
    function _Class() {
      this.load = __bind(this.load, this);
    }

    _Class.prototype.load = function(spritesURL) {
      return getJSON(spritesURL, function(sprites) {
        return defer(function() {
          return LemonSoda.processSprites(sprites);
        });
      });
    };

    _Class.prototype.processSprites = function(sprites) {
      var maxBlockTime, name, sprite, start, _results;
      maxBlockTime = 50;
      start = new Date;
      _results = [];
      for (name in sprites) {
        sprite = sprites[name];
        addRule("." + name, "            background: url(" + sprite.uri + ");            width:" + sprite.w + "px;            height:" + sprite.h + "px;");
        delete sprites[name];
        if ((new Date) - start >= maxBlockTime) {
          defer(function() {
            return LemonSoda.processSprites(sprites);
          });
          break;
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    return _Class;

  })());

  defer = function(cb) {
    return setTimeout(cb, 1);
  };

  getJSON = function(url, cb) {
    var req;
    req = new XMLHttpRequest;
    req.onload = function() {
      return cb(JSON.parse(this.responseText));
    };
    req.open('get', url, true);
    return req.send();
  };

  styleRoot = (_ref = document.head) != null ? _ref : document.body;

  styleRoot.appendChild(style = document.createElement('style'));

  sheet = style.sheet;

  if (sheet != null) {
    if (sheet.addRule) {
      addRule = function(sel, rule) {
        return sheet.addRule(sel, rule);
      };
    } else if (sheet.insertRule) {
      addRule = function(sel, rule) {
        return sheet.insertRule("" + sel + " { " + rule + " }", 0);
      };
    }
  }

  if (addRule == null) {
    addRule = function(sel, rule) {
      return style.innerText += "" + sel + " { " + rule + " }";
    };
  }

}).call(this);
