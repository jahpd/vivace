// Generated by CoffeeScript 1.4.0
(function() {
  var exec, pushMethod;

  pushMethod = function(def) {
    return Vivace.voices[def.name.val][def.attr.val] = def.is.val.reverse();
  };

  Vivace.voices.enable = function(name) {
    return Vivace.voices[name].isAvailable = true;
  };

  Vivace.voices.unable = function(name) {
    return Vivace.voices[name].isAvailable = false;
  };

  exec = function(lang, input, callback) {
    var exec_voices, tree;
    tree = null;
    if (lang === 'vivace_lang') {
      tree = window.vivace_lang.parse(input);
    }
    exec_voices = {
      current: Vivace.voices,
      active: []
    };
    $.each(tree.code.definitions, function(i, definition) {
      var haveElement;
      Vivace.voices.unable(definition.name.val);
      pushMethod(definition);
      if (exec_voices.active.length === 0) {
        return exec_voices.active.push(definition.name.val);
      } else {
        haveElement = exec_voices.active.indexOf(definition.name.val) >= 0;
        if (!haveElement) {
          return exec_voices.active.push(definition.name.val);
        }
      }
    });
    return callback(exec_voices);
  };

  if (!window.Vivace) {
    window.Vivace = {};
  }

  window.Vivace.exec = exec;

}).call(this);