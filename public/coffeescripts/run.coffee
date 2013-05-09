# ./run.coffee

voices = window.Vivace.voices
lastvoices = window.Vivace.lastvoices
			
Vivace.loadcode = (filename, callback) ->
	request = new XMLHttpRequest();
	url = '../../codes/' + filename
	request.open 'GET', url, true;
	request.responseType = 'text'
	request.onload = () -> callback(request.response)
	request.onerror = () -> console.log 'error while loading file from ' + url
	request.send()

conf = (runvoice) ->
	console.log runvoice

run = (file, ext='.vivace') -> Vivace.loadcode file+ext, (file) -> Vivace.exec file, (variables) -> conf variables
	
window.Vivace.run = run
