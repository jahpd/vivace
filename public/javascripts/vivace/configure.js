// Generated by CoffeeScript 1.4.0
(function() {

  Vivace.loadscripts(['vivace_lang', 'init', 'loadMedias', 'menu', 'mixer', 'play', 'tick', 'exec', 'run', 'keyboard'], function(start, src) {
    return $(document).ready(function() {
      if (src === 'init') {
        start[src] = function() {
          return Vivace.init(Vivace.environment, function(voicename) {
            return console.log(voicename + ' initialized');
          });
        };
      } else if (src === 'loadMedias') {
        start[src] = function() {
          return Vivace.loadMedias(function(envName, filename, fileType, loader) {
            loader(envName, filename, fileType);
            return console.log(name + ' loading ' + filename + '...');
          });
        };
      } else if (src === 'menu') {
        start[src] = function() {
          return Vivace.menu.create('#banner', Vivace.menu.banner, function(menuitem) {
            return console.log(menuitem + ' added');
          });
        };
      } else if (src === 'keyboard') {
        start[src] = function() {
          return Vivace.keyboard.create(function(keycontrols) {
            return $.each(keycontrols, function(k, keys) {
              return console.log('add listener to button ' + k);
            });
          });
        };
      } else {
        start[src] = function() {};
      }
      console.log(src + ' loaded');
      return start[src]();
    });
  });

}).call(this);
