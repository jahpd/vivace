
#attach = (elem,doc, disabled=false) ->
#	elem.disabled = disabled;
#	doc.attach_textarea(elem);
#	console.log('vivace textarea shared')
	
#sharejs.open 'default', 'text', (error, doc) ->
#	if error then console.log error
#	if !error then attach document.getElementById('code'), doc
	
Vivace.loadscripts [
	'vivace_lang'
	'init'
	'loadMedias'
	'menu'
	'mixer'
	'play'
	'tick'
	'exec'	
	'run'
	'keyboard'
], (start, src) ->
	$(document).ready () ->
		if src == 'init'
			start[src] = () -> Vivace.init Vivace.environment, (voicename) -> 
				console.log voicename+' initialized'
		else if src == 'loadMedias'
			start[src] = () -> Vivace.loadMedias (envName, filename, fileType, loader) -> 
				loader(envName, filename, fileType)
				console.log name+' loading '+filename+'...'
		else if src == 'menu'
			start[src] = () -> 
				Vivace.menu.create '#banner', Vivace.menu.banner, (menuitem) -> console.log menuitem+' added'		 
		else if src == 'keyboard'
			start[src] = () ->
				Vivace.keyboard.create (keycontrols) ->
					$.each keycontrols, (k, keys) -> console.log 'add listener to button '+k
		else
			start[src] = () ->
					
		console.log src+' loaded'
		start[src]()