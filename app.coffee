# First compile coffee-scripts
fs = require 'fs'
coffee = require 'coffee-script'
vivace = require './routes/vivace'

module.exports = () ->
	for dir in ['routes', 'public']
		console.log "compliling coffee-scripts in #{dir}"
		dirList = fs.readdirSync if dir != './' then "#{dir}/coffeescripts" else '#{dir}'
	for file in dirList
		if  /\.(js|coffee)$/.test file
			console.log coffee.compile
			coffee.compile file
			console.log "\t#{file}"
	
	console.log "Vivace by coffee-script #{coffee.VERSION}"	

	#app;
	app = vivace()

	#lazy configuration
	app.configure () ->
		#root page: will be the application
		app.get '/', vivace.root

		#login logout
		app.get '/login', vivace.login
		app.post '/login', vivace.login_handler
		app.get '/logout', vivace.logout

		#The developers pages
		app.get '/developers', vivace.developers

		#The help pages
		app.get '/help', vivace.help

		app.listen 3000, vivace.test
	
	app.pass = true