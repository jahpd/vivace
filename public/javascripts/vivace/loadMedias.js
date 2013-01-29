// Generated by CoffeeScript 1.4.0
(function() {

  Vivace.loadMedias = function(callback) {
    var voices;
    voices = Vivace.voices;
    return $.each(voices, function(name, voice) {
      if (voice.sigType === 'audio') {
        callback(name, voice.sig, voice.sigType, Vivace.loadAudioFile);
      }
      if (voice.sigType === 'video') {
        return callback(name, voice.sig, voice.sigType, Vivace.loadVideoFile);
      }
    });
  };

  Vivace.loadAudioFile = function(voicename, filename, filetype, audioFilesDir) {
    var request, url;
    if (audioFilesDir == null) {
      audioFilesDir = '../../audios/';
    }
    request = new XMLHttpRequest();
    url = audioFilesDir + filename;
    request.open('GET', url, true);
    request.responseType = 'arraybuffer';
    request.onload = function() {
      return Vivace.audiocontext.decodeAudioData(request.response, function(buffer) {
        var options;
        options = {
          buffer: buffer,
          pan: [-1, 1],
          gain: [0, 1]
        };
        return Vivace.mixer.create(voicename, options, function(audionodes, controls) {
          audionodes.src.connect(audionodes.pan);
          audionodes.pan.connect(audionodes.gain);
          audionodes.gain.connect(Vivace.audiocontext.destination);
          controls.pan.onChange(function(value) {
            return audionodes.pan.setPosition(value * 10, 0, 0);
          });
          controls.gain.onChange(function(value) {
            return audionodes.gain.gain.value = value;
          });
          return $.each(audionodes, function(k, v) {
            console.log(k + ' added to ' + voicename + ': ' + v);
            if (k !== 'src') {
              return console.log('added listeners to ' + k);
            }
          });
        });
      });
    };
    request.onerror = function() {
      return console.log('error while loading audio file from ' + url);
    };
    return request.send();
  };

  Vivace.loadVideoFile = function(voicename, filename, filetype, audioFilesDir) {
    var popcorn, vid;
    if (audioFilesDir == null) {
      audioFilesDir = '../../videos/';
    }
    vid = document.getElementsByTagName('video')[0];
    vid.src = audioFilesDir + filename;
    vid.id = 'voice_' + voicename;
    Vivace.voices[voicename].popcorn = popcorn = Popcorn('#' + vid.id);
    return popcorn.preload('auto');
  };

}).call(this);