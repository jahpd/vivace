Vivace.loadMedias = (callback) ->
	#loop through provided environment
	#get all mixer parameters
	$.each Vivace.voices, (name, voice) ->
		if voice.sigType=='audio' then callback name, voice, Vivace.loadAudioFile
		if voice.sigType=='video' then callback name, voice, Vivace.loadVideoFile

_options = (voicename, buffer) ->
	sr = Vivace.audiocontext.sampleRate / 2
	opt = 
		'buffer': buffer
		'pan': {min: -1, max: 1, onChange: (value) -> 
			v = value * 10
			Vivace.audionodes[voicename].setPosition(0, v, 0)
			console.log voicename+'(pan):'+value
		}
		'gain':{min: 0, max: 1, onChange: (value) -> 
			Vivace.audionodes[voicename].gain.value = value
			console.log voicename+'(gain):'+value
		}
		#filters:
		#	high:{ active:{value:false, onChange: (value) ->}, type: 1, max: sr, min: sr/2000, Q: {value: 1, onChange: (value) -> },  gain: {value: 0, onChange: (value) -> }
		#	low:{ active:{value:false, onChange: (value) ->}, type: 0, max: sr, min: sr/2000, Q: {value: 1, onChange: (value) -> },  gain: {value: 0, onChange: (value) -> }
					
Vivace.loadAudioFile = (voicename, filename, callback, audioFilesDir='../../audios/') ->
	request = new XMLHttpRequest();
	url = audioFilesDir + filename;
	request.open 'GET', url, true;
	request.responseType = 'arraybuffer';
	request.onload = () -> Vivace.audiocontext.decodeAudioData request.response, (buffer) -> callback voicename, _options(voicename, buffer)					
	request.onerror = () -> console.log 'error while loading audio file from ' + url
	request.send()

Vivace.loadVideoFile = (voicename, filename, audioFilesDir='../../videos/') ->
	vid = document.getElementsByTagName('video')[0];
	vid.src = audioFilesDir + filename;
	vid.id = 'voice_'+voicename;
	#vid.setAttribute 'controls', false
	#vid.setAttribute 'autoplay', false
	#document.getElementsByTagName('body')[0].appendChild vid 
	Vivace.voices[voicename].popcorn = popcorn = Popcorn '#'+vid.id
	popcorn.preload 'auto'