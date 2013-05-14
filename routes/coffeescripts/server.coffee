class VivaceServer
	constructor: (@title, @clientScripts, @menu) -> 
		{@app, @share, @mountpoint} = [express(), sharejs.server, '/']
	
	respond: (login) -> new Response @

	get: (what, func) -> @app.get what, func
	
	post: (what, func) -> @app.post what, func
	
	listen: (port, callback) ->
		@app.listen port
		if callback then callback()
		console.log "vivace running at http://127.0.0.1:#{port}"
		
	configure: (callback, sessions=true, dev=true)->
		#attach the sharejs REST and Socket.io interfaces to the server
		@share.attach @app, {db: {type: 'none'}};
		
		#configure express application with sessions and dev arguments
		@app.configure () ->
			@app.set 'views', "#{__dirname}/views"
			@app.set 'view engine', 'jade'
			#app.set('view options', { layout: false });
			@app.use express.favicon()
			if dev then @app.use express.logger 'dev' 
			@app.use express.bodyParser()
			@app.use express.methodOverride()
			if sessions
				@app.use express.cookieParser 'your secret here'
				@app.use express.session()
			@app.use express_app.router
			@app.use require('stylus').middleware("#{__dirname}/public");
			@app.use express.static path.join(__dirname, 'public')
		if dev then @app.configure 'development', ()-> express_app.use express.errorHandler()
		callback

module.exports = (title, clientScripts, proto) -> new VivaceServer title, clientScripts, proto