# !DOC
# This function initialize all necessarie resources
# @param what the thing to initialize
Vivace.init = (what, args..., callback=(module, obj)-> console.log module+' created: '+obj) ->
	if what == 'audiocontext'
		obj = initAudioContext()
	else if what == 'voices' 
		obj = initVoices()
	else if what == 'processing'
		obj = initProcessing()
	else if what == 'dat.GUI'
		obj = new dat.GUI()
	#now add module
	Vivace.module what, obj, callback

initAudioContext = () -> if typeof AudioContext != "undefined" then new AudioContext() else new webkitAudioContext()

Voice = (name, other) ->
	o = 
		name: name
		value: null
		isAudio: false
		isVideo: false
		isSynth: false
		isGraph: false
		isText: false
		isAvailable: true
		audionodes: null
		processingnodes: null
	if other then $.each other, (k, v) -> o[k] = v
	o
	
initVoices = () -> $.map 'qwertyuiopsdfghjklzxcvbnm', (k, n) -> Voice k
	
#load this when module are add
initProcessing = () -> {
	canvas: document.getElementById 'vivace_canvas'
	draw: (func) -> Vivace.processing.draw = func
}