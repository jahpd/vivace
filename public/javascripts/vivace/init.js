// Generated by CoffeeScript 1.4.0
(function() {
  var init;

  init = function(environment, callback) {
    var voices;
    voices = window.Vivace.voices;
    $.each(environment, function(i, variable) {
      voices[variable.name] = {
        sig: variable.fileName,
        sigType: variable.type,
        isAvailable: true,
        audionodes: {}
      };
      if (callback) {
        return callback(variable.name);
      }
    });
    return voices;
  };

  window.Vivace.init = init;

}).call(this);