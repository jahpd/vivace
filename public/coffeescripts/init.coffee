#./init.coffee

# DOC
# This function initialize Vivace-lang
# @param environment the Vivace environment to be loaded, gennerally the Vivace.environment
# @param callback a callback function executed after init process is finished, if not provided, a default will be executed
init = (callback) ->
	#a helper copy of environment
	voices = window.Vivace.voices
	
	#loop through provided environment
	$.each Vivace.environment, (i, variable) ->
		# create a dict to each voice
		voices[variable.name] =
			sig: variable.fileName 
			sigType: variable.type
			isAvailable: true
			audionodes: {}
		
		#when finished, callbacks
		if callback then callback(variable.name)	

	#return
	voices
			
#expose method
window.Vivace.init = init