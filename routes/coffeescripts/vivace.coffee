server = require('./server')

module.exports = (json, callback) ->
	# inside menu, put a prototype of app and their menu
	if callback then callback json
	server 'vivace', json.client.scripts, json.mountpoints