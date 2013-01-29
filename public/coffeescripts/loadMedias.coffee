Vivace.loadMedias = (callback) ->
	#loop through provided environment
	voices = Vivace.voices
	
	#get all mixer parameters
	$.each voices, (name, voice) ->
		#callback
		if voice.sigType=='audio' then callback name, voice.sig, voice.sigType, Vivace.loadAudioFile
		if voice.sigType=='video' then callback name, voice.sig, voice.sigType, Vivace.loadVideoFile

Vivace.loadAudioFile = (voicename, filename, filetype, audioFilesDir='../../audios/') ->
	request = new XMLHttpRequest();
	url = audioFilesDir + filename;
	request.open 'GET', url, true;
	request.responseType = 'arraybuffer';

	request.onload = () ->
		#add some audio nodes
		Vivace.audiocontext.decodeAudioData request.response, (buffer) -> 
			options = 
				buffer: buffer
				pan: [-1, 1]
				gain: [0, 1]
			
			#route created audio nodes according are loaded the audio
			Vivace.mixer.create voicename, options, (audionodes, controls) -> 
				#Apply audio routing 
				audionodes.src.connect(audionodes.pan)
				audionodes.pan.connect(audionodes.gain)	
				audionodes.gain.connect(Vivace.audiocontext.destination)
				
				#Apply audio controler listeners
				controls.pan.onChange (value) -> audionodes.pan.setPosition(value * 10, 0, 0)
				controls.gain.onChange (value) -> audionodes.gain.gain.value = value
				
				$.each audionodes, (k, v) -> 
					console.log k+' added to '+voicename+': '+v
					if k != 'src' then console.log 'added listeners to '+k
					
	request.onerror = () -> console.log 'error while loading audio file from ' + url
	
	request.send()

Vivace.loadVideoFile = (voicename, filename, filetype, audioFilesDir='../../videos/') ->
	vid = document.getElementsByTagName('video')[0];
	vid.src = audioFilesDir + filename;
	vid.id = 'voice_'+voicename;
	#vid.setAttribute 'controls', false
	#vid.setAttribute 'autoplay', false
	#document.getElementsByTagName('body')[0].appendChild vid 
	Vivace.voices[voicename].popcorn = popcorn = Popcorn '#'+vid.id
	popcorn.preload 'auto'