vivace = require './routes/vivace'

json = 
	client:
		scripts: "#{folder}/#{file}.js" for file in fs.readdir 'public/javascripts'
	mountpoints:
		log_in_out:
			title: 'login'
			href: '/login'
			code: 'codes/log_in_out.vivace'
		developers:
			title: 'devlopers'
			href: '/developers'
			code: 'codes/dev.vivace'
		help:
			title: 'help'
			href: '/help'
			code: 'codes/help.vivace'
		log:
			title: 'log'
			href: '/log'
			code: 'codes/log.vivace'
			
app = vivace json

vivace.configure () ->
	vivace.bind 'root', (req, res) =>	
		console.log 'Vivace server response for /'
		if !req.session.username then @menu.log = '/login' else @menu.log = '/logout'
		console.log @json
		res.render 'index', @json
		
	vivace.bind 'login', (req, res) =>
		console.log 'Vivace server response for /login'
		res.render 'login', {}
	
	vivace.bind 'login_handler', (req, res) =>
		req.session.username =  req.body.name || "anonymous"
		res.redirect "/?user=#{req.session.username}"
		
	vivace.bind 'developers', (req, res, string) =>
		guys = 'aut0mata greenkobold cravelho gabiTume'
		res.render string, vivace.result string, guys , { 
			title: 'Vivace developers' 
			src: 'http://github.com'
		}
	
	vivace.bind 'help', (req, res, string) ->
		things = 'using forkus'
		res.render string, vivace.result string, things, {
			title:'Vivace help'
		}

##vivace.route '/ /developers /help', (dir, handler)-> vivace.get dir, handler