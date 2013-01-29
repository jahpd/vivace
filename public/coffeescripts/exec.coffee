## ./vivace_exec.coffee
## VIVACE EXEC INPUT CODE MODULE
#check the medias

pushMethod = (def) -> Vivace.voices[def.name.val][def.attr.val] = def.is.val.reverse()
Vivace.voices.enable = (name) -> Vivace.voices[name].isAvailable = true
Vivace.voices.unable = (name) -> Vivace.voices[name].isAvailable = false
	
exec = (lang, input, callback) ->
	#add support to multiple tastes of vivace
	tree = null
	if lang == 'vivace_lang' then tree = window.vivace_lang.parse input
	
	exec_voices = 
		current: Vivace.voices
		active: []

	#return a modified copy of Vivace.voices
	$.each tree.code.definitions, (i, definition) -> 
		#stop to update in future
		Vivace.voices.unable definition.name.val
	
		#add method from code
		pushMethod definition
		
		#add the active voice once
		if exec_voices.active.length == 0
			exec_voices.active.push definition.name.val
		else  
			#check if the voice is alredy in array
			haveElement = exec_voices.active.indexOf(definition.name.val) >= 0
			if !haveElement then exec_voices.active.push definition.name.val
	
	callback(exec_voices)
	
	
#expose exec module
if !window.Vivace then window.Vivace = {}
window.Vivace.exec = exec