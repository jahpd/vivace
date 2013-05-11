vivace = require './routes/vivace'
app = vivace()

vivace.configure () ->
	
	vivace.bind 'developers', (req, res, string) ->
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