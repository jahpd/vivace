// Generated by CoffeeScript 1.4.0
(function() {
  var fizzy, gui, mixer;

  fizzy = function() {
    this.pan = 0;
    return this.gain = Math.sqrt(2);
  };

  gui = new dat.GUI();

  mixer = {
    audiofy: function(voicename, fizzy, buffer) {
      var voice;
      voice = Vivace.voices[voicename];
      voice.audionodes.src = Vivace.audiocontext.createBufferSource();
      voice.audionodes.src.buffer = buffer;
      $.each(fizzy, function(k, param) {
        var gain, pan;
        if (k === 'gain') {
          gain = voice.audionodes[k] = window.Vivace.audiocontext.createGain();
          return gain.gain.value = param;
        } else if (k === 'pan') {
          pan = voice.audionodes[k] = window.Vivace.audiocontext.createPanner("equalpower", "exponential");
          return pan.setPosition(0, 0, 0);
        }
      });
      return voice.audionodes;
    },
    create: function(voicename, options, callback) {
      var audionodes, controls, folder, voicefizzy;
      folder = gui.addFolder(voicename);
      voicefizzy = new fizzy();
      controls = {};
      $.each(options, function(option, value) {
        if (option !== 'buffer') {
          return controls[option] = folder.add(voicefizzy, option, value[0], value[1]);
        }
      });
      audionodes = Vivace.mixer.audiofy(voicename, voicefizzy, options.buffer);
      return callback(audionodes, controls);
    }
  };

  window.Vivace.mixer = mixer;

}).call(this);
