# ./update.coffee
updateEvent = (eventName, value) ->
	Vivace.events[eventName] = value 

updateMethodId = (voice, methodname) ->
	voice[methodname+'Id'] += 1
	voice[methodname+'Id'] += 1
	voice[methodname+'Id'] += 1

dict = (voice, method) ->
	_dict = {}
	_dict['value'] = voice[method]
	_dict['id'] =  voice[method+'Id']
	_dict
	
tick = (voicename, callback) ->
	
	Vivace.beats += 1
	allvoices = Vivace.voices
	lastVoices = Vivace.lastVoices
	events = Vivace.events
	semiBreve = Vivace.semiBreve

	$.each events, (eventname, event) ->
		if eventname == 'id'
			if event == voice._name
				voice = allvoices[event]
				lastVoice = lastVoices[event]
				_durDict = dict lastVoice, 'dur'
				_posDict = dict lastVoice, 'pos'
				_gdurDict = dict lastVoice, 'gdur'
				_durId = _durDict.id % _durDict.value.length | 0
				Vivace.events.nextbeat = (_durDict.value[_durId].val * semiBreve)+ Vivace.beats; 
		
				if voice.sigType == 'audio' 
					_posId = _posDict.id % _posDict.value.length | 0
					_gdurId = _gdurDict.id % _gdurDict.value.length | 0
					_time = window.Vivace.audiocontext.currentTime
					_offset = _posDict.value[_posId].val
					_graintime = _gdurDict.value[_gdurId].val
					callback {type:'audio', time:_time, offset:_offset, graintime:_graintime}, 
						Vivace.events.nextbeat
		
				#or if our voice is a video
				else if lastVoices[i].sigType == 'video'
					_posId = _posDict.id % _posDict.value.length | 0
					_pos = _posDict.value[_posId]
					callback {type:'video', pos:_pos}, 
						Vivace.events.nextbeat
			
				updateMethodId voice, 'dur'	
				updateMethodId voice, 'pos'	
				updateMethodId voice, 'gdur'	
				updateEvent 'nextbeat', Vivace.events.nextbeat

update = (voicename, callback) -> 
	$('div.dg.main').ready () -> 
		tick voicename, (options, nextbeat) -> 
			if options.type == 'audio'
				Vivace.playVoice voicename, options.time, options.offset, options.graintime
			if options.type == 'video'
				$('#voice_'+voice._name).css 'z-index', '900'
				Vivace.playVideo voicename, options.pos
			callback voicename, nextbeat
	
window.Vivace.update = update
window.Vivace.masterClock = setInterval(Vivace.tick, Vivace.timeInterval);
