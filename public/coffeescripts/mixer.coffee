#some definitions

fizzy = () ->
	this.pan = 0			#middle spatial reference
	this.gain = Math.sqrt(2)	# -3dB sound 
		
#create a new gui
gui = new dat.GUI()

# vivace mixer
# treat a class:
mixer = 
	
	#configure audio nodes
	audiofy: (voicename, fizzy, buffer) ->
		#get audio src
		voice = Vivace.voices[voicename]
		
		#create a src node with provided buffer
		voice.audionodes.src = Vivace.audiocontext.createBufferSource();
		voice.audionodes.src.buffer = buffer
		
		#to each audio parameter, create an appropriate AudioNode
		$.each fizzy, (k, param) ->
			#add node gain
			if k == 'gain' 
				gain = voice.audionodes[k] = window.Vivace.audiocontext.createGain()
				gain.gain.value = param	
			#add pan
			else if k == 'pan' 
				pan = voice.audionodes[k] = window.Vivace.audiocontext.createPanner("equalpower", "exponential")
				pan.setPosition 0, 0, 0							
		voice.audionodes
		
	#create an mixer to specific voice in Vivace
	create: (voicename, options, callback) ->
		#create a folder to voicename
		folder = gui.addFolder(voicename)
		
		#create controls
		voicefizzy = new fizzy()
		controls = {}
		$.each options, (option, value) ->
			if option != 'buffer' then controls[option] = folder.add voicefizzy, option, value[0], value[1]
			
		#now add a new audionode to specific voice
		audionodes = Vivace.mixer.audiofy voicename, voicefizzy, options.buffer
		callback audionodes, controls
					
#expose
window.Vivace.mixer = mixer