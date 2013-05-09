# !DOC
# Main static Object
Vivace = 
	modules: {}
	
	# !DOC
	# add module to Vivace
	# @param string name
	# @param object obj
	# @param function callback
	module: (name, obj, callback) ->
		Vivace[name] = obj
		if callback then callback(name, obj)
		obj 
	
	createMethods: (obj, methods...) -> 
		if obj.hasOwnProperty 'methods' 
			$.each methods, (k, v) -> obj.methods[k] = v 
		else 
			throw new Error()
	
	environment: 
		# TODO top object to control processing in vivace
		P5: 
			type: 'object'
			methods: {}
		# TODO top object to control synthesis in webkitAudioContext
		Synth:
			type: 'object'
			methods:{}
		# TODO top object to get files in specified url (i.e., local, youtube, soundcloud, etc.)
		Url: 
			type: 'object'
			methods: {}
	
	# !DOC 
	# Running executable vars in vivace_command
	executables: {}
	
	# !DOC
	# Last voices 
	last_executables: {}
	
	# !DOC
	# events of each name
	events: 
		id:[]
		currentbeat:[]
		nextbeat:[]
		push: (o) -> $.each o, (k, v) -> if k == 'id' or  k == 'currentbeat' or  k == 'nextbeat' then Vivace.events[k].push v
	
	# !DOC
	# add variable to environment dynamically (i.e, when we can have some support to automatcally download and upload)
	addToEnv: (name, obj) -> Vivace.environment[name] = obj
	
	# !DOC
	# the metronome of Vivace
	beats: 0
	
	# !DOC
	bpm: 120 													# 120 seminimas per minute
	minimalUnity: this.bpm * 4; 								# we tick at each 960 seminimas (or, 1 semifusa) 
	timeInterval: this.minimalUnity / this.minimalUnity * 1000 	# so, at each 62.5 ms we tick 
	semiBreve: 32  												#one semibreve is equal to 64 semifusas (hemidemisemiquaver) (or 32 fusas)
																#change 64:semifusa 32:fusa 16:colcheia 8:seminima
    
	isRunning: false

	onload: (src, callback) ->
		folder='javascripts/vivace/'
		$('body').ready () ->
			$script = $('<scr'+'ipt/>').attr 'type', 'text/javascript'
			$script.attr 'src', folder+src+'.js'
			$('body').append $script
			callback()
			console.log src+' 4 Vivace loaded'

window.Vivace = Vivace	

onLoad = (scripts) -> $(document).ready () -> $.each scripts, (script, callback) -> Vivace.onload script, callback 

onLoad {
	'vivace_lang': () -> 
	'init': () ->
		Vivace.init 'voices', (name, obj) -> 
			console.log 'all available objects: '
			console.log o.name for o in obj
	'processing': () -> 
		Vivace.init 'processing', (name, obj) ->
			new Processing obj.canvas, (processing) -> 
				processing.setup = () -> 
					processing.size window.outerWidth, window.outerHeight
					processing.smooth()
				obj.draw = processing.draw = () -> 
					processing.background 0
					#TODO get all methods in vivace command and put here during livecoding
	'exec': () ->
	'run': () -> 
		$(document).ready () ->
			textarea = document.getElementById 'vivace_command'
      		sharejs.open 'vivace_command', 'text', (error, doc) ->
        		if error then throw new Error();
        		elem.disabled = false;
       			doc.attach_textareactextarea 
      			Vivace.run() 
}		