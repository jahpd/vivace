
#attach = (elem,doc, disabled=false) ->
#	elem.disabled = disabled;
#	doc.attach_textarea(elem);
#	console.log('vivace textarea shared')
	
#sharejs.open 'default', 'text', (error, doc) ->
#	if error then console.log error
#	if !error then attach document.getElementById('code'), doc

load = (scripts) -> $(document).ready () -> $.each scripts, (script, callback) -> Vivace.onload script, callback 

load {
	'vivace_lang': () ->
	'init': () -> Vivace.init (voicename) -> console.log voicename+' initialized'
	'mixer': () -> 
	'loadMedias': () -> 
		Vivace.loadMedias (name, voice, loader) -> 
			console.log name+' loading '+voice.sig+'...'
			if voice.sigType == 'audio' then loader name, voice.sig, Vivace.mixer.createChannel
			if voice.sigType == 'video' then loader name, voice.sig
	'menu': () -> Vivace.menu.create '#banner', Vivace.menu.banner, (menuitem) -> console.log menuitem+' added'	
	'play': () ->
	'tick': () ->
	'exec': () ->
	'keyboard': () -> Vivace.keyboard.create (keycontrols) -> $.each keycontrols, (k, keys) -> console.log 'add listener to button '+k
	'run': () -> $('div.dg:last').ready () -> Vivace.run()
}
	
		
		