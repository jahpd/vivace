class Response
	constructor: (server) ->
		{@title, @menu, @clientScripts, @mountpoint} = server
		@login_state = false
		
	log: -> console.log 'Vivace server response for #{@mountpoint}'
	
	register: (vars...) -> 
		@login_state = true
		@variables = vars

	unregister: -> 
		@login_state = false
		@variables = vars

exports.Response = Response