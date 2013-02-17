OSX = 
	enter: 13
	command: 91
	point: 190

LINUX = {}
WINDOWS = {}

Vivace.keyEvents = keyEvents =  
	keys: 
		enter: {ref: OSX.enter, val: false}
		ctrl: {ref: OSX.command, val: false}
		point: {ref: OSX.point, val: false}
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
		if e.which == keyEvents.keys.ctrl.ref then keyEvents.keys.ctrl.val=false	
		if e.which == keyEvents.keys.enter.ref then keyEvents.keys.enter.val=false		
		if e.which == keyEvents.keys.point.ref then keyEvents.keys.point.val=false		
		
	onkeydown: (e) -> 
		if e.which == keyEvents.keys.ctrl.ref then keyEvents.keys.ctrl.val=true	
		if e.which == keyEvents.keys.enter.ref then keyEvents.keys.enter.val=true		
		if e.which == keyEvents.keys.point.ref then keyEvents.keys.point.val=true
		
		Vivace.keyboard.runvoices keyEvents.keys.ctrl.val, keyEvents.keys.enter.val, keyEvents.keys.point.val
	
	#enable the Vivace.keyboard
	create: (callback) ->
		document.onkeydown=Vivace.keyboard.onkeyup;
		document.onkeydown=Vivace.keyboard.onkeydown;
		if callback then callback(Vivace.keyEvents.keys) 		
