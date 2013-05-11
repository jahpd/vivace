fs = require 'fs'
express = require 'express'
sharejs = require 'share'
path = require 'path'

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
	
class VivaceServer
	constructor: (@title, @clientScripts, @menu) -> 
		{@app, @share, @mountpoint} = [express(), sharejs.server, '/']
	
	get: (what, func) -> @app.get what, func
	
	post: (what, func) -> @app.post what, func
	
	listen: (port, callback) ->
		@app.listen port
		if callback then callback()
		console.log "vivace running at http://127.0.0.1:#{port}"
		
	configure: (callback)->
		#attach the sharejs REST and Socket.io interfaces to the server
		@share.attach @app, {db: {type: 'none'}};
		@app.configure () ->
			@app.set 'views', "#{__dirname}/views"
			@app.set 'view engine', 'jade'
			#app.set('view options', { layout: false });
			@app.use express.favicon()
			@app.use express.logger 'dev' 
			@app.use express.bodyParser()
			@app.use express.methodOverride()
			@app.use express.cookieParser 'your secret here'
			@app.use express.session()
			@app.use express_app.router
			@app.use require('stylus').middleware("#{__dirname}/public");
			@app.use express.static path.join(__dirname, 'public')
		@app.configure 'development', ()-> express_app.use express.errorHandler()
		callback
	
	root: (req, res) ->	
		console.log 'Vivace server response for /'
		if !req.session.username then @menu.log = '/login' else @menu.log = '/logout'
		console.log @json
		res.render 'index', @json

	login: (req, res) ->
		console.log 'Vivace server response for /login'
		res.render 'login', {}
	
	logout: (req, res) ->
		delete req.session.username
		res.redirect '/'

	login_handler: (req, res) ->
		req.session.username =  req.body.name || "anonymous"
		res.redirect "/?user=#{req.session.username}"

exports.server = VivaceServer