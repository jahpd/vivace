// Generated by CoffeeScript 1.4.0
(function() {
  var Vivace, m;

  Vivace = {};

  Vivace.environment = [
    {
      name: 'a',
      fileName: 'kick.wav',
      type: 'audio'
    }, {
      name: 'b',
      fileName: 'dj.wav',
      type: 'audio'
    }, {
      name: 'c',
      fileName: 'snare.wav',
      type: 'audio'
    }, {
      name: 'd',
      fileName: 'hihat.wav',
      type: 'audio'
    }, {
      name: 'i',
      fileName: 'illuminatti.mp4',
      type: 'video'
    }
  ];

  Vivace.events = {
    id: [],
    currentbeat: [],
    nextbeat: [],
    push: function(o) {
      return $.each(o, function(k, v) {
        if (k === 'id' || k === 'currentbeat' || k === 'nextbeat') {
          return Vivace.events[k].push(v);
        }
      });
    }
  };

  Vivace.voices = {};

  Vivace.lastVoices = null;

  Vivace.addToEnv = function(n, fn, t) {
    return Vivace.environment.push({
      name: n,
      fileName: fn,
      type: t
    });
  };

  Vivace.beats = 0;

  Vivace.bpm = 120;

  Vivace.minimalUnity = m = Vivace.bpm * 4;

  Vivace.timeInterval = m / m * 1000;

  Vivace.semiBreve = 32;

  if (typeof AudioContext !== "undefined") {
    Vivace.audiocontext = new AudioContext();
  } else if (typeof webkitAudioContext !== "undefined") {
    Vivace.audiocontext = new webkitAudioContext();
  } else {
    throw new Error('AudioContext not supported.');
  }

  Vivace.isRunning = false;

  Vivace.onload = function(src, callback) {
    var folder, start;
    folder = 'javascripts/vivace/';
    start = {};
    return $('body').ready(function() {
      var $script;
      $script = $('<scr' + 'ipt/>').attr('type', 'text/javascript');
      $script.attr('src', folder + src + '.js');
      $('body').append($script);
      return callback();
    });
  };

  window.Vivace = Vivace;

}).call(this);
