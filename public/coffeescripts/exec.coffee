## ./vivace_exec.coffee
## VIVACE EXEC INPUT CODE MODULE
#check the medias

pushMethod = (def) -> Vivace.executables[def.name.val][def.attr.val] = def.is.val.reverse()
enableExecutable = (name) -> if Vivace.executables[name] then Vivace.executables[name].isAvailable = true
unableExecutable = (name) -> if Vivace.executables[name] then Vivace.executables[name].isAvailable = false

addOnce = (def) -> 
	if exec_voices.active.length == 0
		exec_voices.active.push definition.name.val
	else  
		#check if the voice is alredy in array
		haveElement = exec_voices.active.indexOf(definition.name.val) >= 0
		if !haveElement then exec_voices.active.push definition.name.val

Vivace.exec = (input, callback) ->
	# Tree is the all definitions coded in textarea#vivace_command DOM element
	tree = window.vivace_lang.parse input

	Vivace.executables.active = {}
	
	#return a modified copy of Vivace.voices
	$.each tree.code.definitions, (i, definition) -> 
		#stop to update in future
		unableExecutable definition.name.val
	
		#add method from code
		pushMethod definition
		
		#add the active voice once
		enableExecutable definition.name.val
	
	callback executables