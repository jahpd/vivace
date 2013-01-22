# ./share.coffee
# share the vivace textarea
attach = (element,doc, disabled=false) ->
	elem.disabled = disabled;
	doc.attach_textarea(elem);
	console.log('vivace textarea shared')
	
sharejs.open 'default', 'text', (error, doc) ->
	if error then console.log error
	if !error then attach document.getElementById('code'), doc