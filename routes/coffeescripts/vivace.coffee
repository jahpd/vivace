
#mongo = require 'mongoskin'
#db = mongo.db('db://admin:admin@localhost:28017/test?auto_reconnect', {j: true})

fs = require 'fs'

express = require 'express'
sharejs = require 'share'
editor_server = sharejs.server
path = require 'path'
express_app = express()

module.exports = () ->
	# configure, listen, get and post 
	# are override methods for express
	app = this.app = 
		TITLE: 'vivace'				
		MENU:
			log: ''
			developers:'/developers'
			help:'/help'
		SCRIPTS: "#{folder}/#{script}.js" for script in folder when /\.(js)$/.test script for folder in fs.readdirSync 'public/javascripts'
		listen: (port, callback) ->
			express_app.listen port
			if callback then callback()
			console.log "Vivace running at http://127.0.0.1:#{port}"
		
		get: (what, func) -> express_app.get what, func
		post: (what, func) -> express_app.post what, func
		
		configure: (callback)->
			#attach the sharejs REST and Socket.io interfaces to the server
			editor_server.attach express_app, {db: {type: 'none'}};
			express_app.configure ()->
				express_app.set 'views', "#{__dirname}/views"
				express_app.set 'view engine', 'jade'
				#app.set('view options', { layout: false });
				express_app.use express.favicon()
				express_app.use express.logger 'dev' 
				express_app.use express.bodyParser()
				express_app.use express.methodOverride()
				express_app.use express.cookieParser 'your secret here'
				express_app.use express.session()
				express_app.use express_app.router
				express_app.use require('stylus').middleware("#{__dirname}/public");
				express_app.use express.static path.join(__dirname, 'public')
			express_app.configure 'development', ()-> express_app.use express.errorHandler()
			callback
			
		root: (req, res) ->	
			console.log 'Vivace server response for /'
			if !req.session.username
				this.app.MENU.log = '/login'
			else
				this.app.MENU.log = '/logout'
			response = 
				title: this.app.TITLE
				menu: this.app.MENU
			console.log response
			res.render 'index', response
					
		login: (req, res) ->
			console.log 'Vivace server response for /login'
			res.render 'login', {}
	
		logout: (req, res) ->
			delete req.session[user.id]
			res.redirect '/'

		login_handler: (req, res) ->
			req.session.username =  req.body.name || "anonymous"
			res.redirect "/?user=#{req.session.username}"
		
		result: (mounting, list, opt) ->
			list = list.split ' '
			_list = "/#{mounting}?q=#{query}" for query in list
			o = {}
			o[item] = _list[_i] for item in list
			o[item] = opt[_i] for item in opt
			o
			
		developers: (req, res) ->
			s = 'developers'
			res.render s, result(s, 'aut0mata greenkobold cravelho gabiTume', {title: 'Vivace developers', src: 'http://github.com'})
		
		help: (req, res) ->
			s = 'help'
			res.render s, result(s, 'using forkus', {title: 'Vivace help'})
		
		test: () ->
			# make proper tests and notify
			assert = require('assert')