# ./run.coffee

voices = window.Vivace.voices
lastvoices = window.Vivace.lastvoices
			
loadcode = (filename, callback) ->
	request = new XMLHttpRequest();
	url = '../../codes/' + filename
	request.open 'GET', url, true;
	request.responseType = 'text'
	request.onload = () -> callback(request.response)
	request.onerror = () -> console.log 'error while loading audio file from ' + url
	request.send()

confLastVoices = (runvoice) ->
	#get all current and active voices
	currentVoices = runvoice.current
	activeVoices = runvoice.active
	
	#corrigir
	
	#define the runningVoices
	Vivace.lastVoices = {}
	$.each activeVoices, (i, voicename) -> 
		if currentVoices[voicename].sigType == 'video'
			$('video').css 'zIndex', 0
			currentVoice.popcorn.pause()
			
		voice = Vivace.lastVoices[voicename] =
			_name: voicename 
			id: Vivace.environment.indexOf Vivace.voices[voicename]
			durId: 0
			posId: 0
			gdurId: 0
			dur: currentVoices[voicename].dur
			pos: currentVoices[voicename].pos
			gdur: currentVoices[voicename].gdur
			isAvailable: currentVoices[voicename].isAvailable
		
		
		# let's update events
		id = if voice.durId >= voice.dur.length then voice.durId % voice.dur.length else voice.durId
		Vivace.events.push {
			'_name': voicename
			'id': Vivace.environment.indexOf(Vivace.environment[voice._name])
			'currentbeat': voice.dur[id].val
			'nextbeat': voice.dur[id].val * Vivace.semiBreve + Vivace.beats 
		}	
		
		# update and enable to be played
		Vivace.voices.enable voicename
		
run = () -> 
	#load code, and then put it on input and say that Vivace is Running
	loadcode 'default.vivace', (code) ->
		$('textarea').text(code)
		Vivace.exec 'vivace_lang', code, (exec_voices) ->
			confLastVoices exec_voices	
			console.log "text coded objects:"
			console.log exec_voices
			window.Vivace.isRunning = true
			
		
window.Vivace.run = run
