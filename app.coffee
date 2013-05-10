vivace = require './routes/vivace'
app = vivace()

vivace.configure () ->
	vivace.bind 'developers', (req, res, string) ->
		res.render string, vivace. result string, 'aut0mata greenkobold cravelho gabiTume', {title: 'Vivace developers', src: 'http://github.com'}
	
	vivace.bind 'help', (req, res, string) ->
		res.render string, vivace.result string, 'using forkus', {title: 'Vivace help'}

vivace.route '/ /developers /help', (dir, handler)-> vivace.get dir, handler