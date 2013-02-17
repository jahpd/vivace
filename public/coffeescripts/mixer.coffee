#some definitions
#in form

_mixerDef = () ->
	this.pan = 0							
	this.gain = Math.sqrt(2)/2 
	

RoutingMethods =
	_mixerDef: 'src=>gain=>pan=>destination'
	apply:(tree, mixer, def) -> 
		array = def.split('=>')
		if array
			_makeAudioNodes tree, mixer
			_route tree, array
		else
			throw new Error('string is not a valid route method')

_makeAudioNodes = (nodestree, mixer) ->
	$.each mixer, (k, param) ->
		#add node gain
		if k == 'gain'
			nodestree[k] = window.Vivace.audiocontext.createGain()
			nodestree[k].gain.value = param
		#add pan
		else if k == 'pan'
			nodestree[k] = window.Vivace.audiocontext.createPanner("equalpower", "exponential")
			nodestree[k].setPosition 0, 0, 0
	
_route = (nodestree, array) ->
	$.each array, (i, current) ->
		indexCurrent = array.indexOf current
		indexNext = array.indexOf array[i+1]
		
		if indexCurrent > -1 and indexNext > -1 and indexNext > indexCurrent
			nodeA = array[indexCurrent]
			nodeB = array[indexNext]
			if nodeB != 'destination'
				if nodestree[nodeB] != undefined and nodestree[nodeA] != undefined then nodestree[nodeA].connect nodestree[nodeB]
				
			if nodeB == 'destination'
				if nodestree[nodeA] != undefined then nodestree[nodeA].connect Vivace.audiocontext.destination
			
			console.log 'connecting '+nodeA+' -> '+nodeB
			
_createSliders = (folder, mix, voicename, option, value) -> 
	#create a folder to voicename	
	control = null
	if option != 'buffer'
		if option == 'pan' or option == 'gain'
			control = folder.add mix, option, value.min, value.max
			control.onChange = value.onChange

#create a new gui
gui = new dat.GUI()

# vivace mixer
# treat a class:
mixer = 
	#configure audio nodes
	router: (voicename, buffer, mxDef=_mixerDef, routingMethod=RoutingMethods._mixerDef) ->
		#get audio src
		voice = Vivace.voices[voicename]
		
		#create a src node with provided buffer
		source = voice.audionodes.src = Vivace.audiocontext.createBufferSource();
		voice.audionodes.src.buffer = buffer
		
		#to each audio parameter, create an appropriate AudioNode
		_mix = new mxDef()
		try
			RoutingMethods.apply voice.audionodes, _mix, routingMethod
			#return the mixerDefinition and audio chain	
			{
				'mixer': _mix
				#return the configured voice.audionodes
				'chain': voice.audionodes 
			}
		catch e
			console.log e
		
		
	#create an mixer to specific voice in Vivace
	createChannel: (voicename, options, createSliderCallback = _createSliders) ->
		routing = Vivace.mixer.router voicename, options.buffer 
		folder = gui.addFolder voicename	
		$.each options, (option, value) -> createSliderCallback folder, routing.mixer, voicename, option, value
					
#expose
window.Vivace.mixer = mixer