#./playVoice.coffee

playVoice = (voicename, time, offset, duration) ->
	
	voice = Vivace.voices[voicename]
	try
		source = voice.audionodes.src
	catch e
		console.log e
		
	# TODO: here we will use the voices[voiceName].sig dsp graph!!!

	# source.noteOn when || window.Vivace.audiocontext.currentTime;
	if time and offset and duration and voice.isAvailable
		# at specified time or now
		# starting at offset or from start
		# during duration or the whole buffer
		source.noteGrainOn time, offset, duration 
	else
		#default
		source.noteGrainOn context.currentTime , 0, source.buffer.duration 

playVideo = (voicename, offset) -> window.Vivace.voices[voicename].sigPop.play(offset);

#expose methods
window.Vivace.playVoice = playVoice
window.Vivace.playVideo = playVideo