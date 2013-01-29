Vivace.keyEvents = keyEvents =  
	keys: 
		enter: 
			ref: 13
			val: false
		command: 
			ref: 91
			val: false
		point: 
			ref: 190
			val: false
		
	run: (c, e, p, lastVoices) ->
		if c and e
			$.each lastVoices, (i, voiceRef) ->
				#update sounds throug voices
				Vivace.update voiceRef._name, (nextbeat) ->
					console.log 'playing '+voiceRef._name
					console.log 'next beat will be in '+nextbeat 	

window.Vivace.keyboard = 
	runvoices: (c, e, p) -> keyEvents.run c, e, p,  Vivace.lastVoices				
	onkeyup: (e) -> 
		if e.which == keyEvents.keys.command.ref then keyEvents.keys.command.val=false	#command (MacOS)
		if e.which == keyEvents.keys.enter.ref then keyEvents.keys.enter.val=false		#Return (MacOS)
		if e.which == keyEvents.keys.point.ref then keyEvents.keys.point.val=false		#point (MacOS)
		
	onkeydown: (e) -> 
		if e.which == keyEvents.keys.command.ref then keyEvents.keys.command.val=true	#command (MacOS)
		if e.which == keyEvents.keys.enter.ref then keyEvents.keys.enter.val=true		#Return (MacOS)
		if e.which == keyEvents.keys.point.ref then keyEvents.keys.point.val=true
		
		Vivace.keyboard.runvoices keyEvents.keys.command.val, 
			keyEvents.keys.enter.val, 
			keyEvents.keys.point.val
	
	#enable the Vivace.keyboard
	create: (callback) ->
		document.onkeydown=Vivace.keyboard.onkeyup;
		document.onkeydown=Vivace.keyboard.onkeydown;
		callback(Vivace.keyEvents.keys) 		

