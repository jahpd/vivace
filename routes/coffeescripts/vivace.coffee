fs = require 'fs'
Task = require('./routes/task')


module.exports = (json, callback) ->
	# inside menu, put a prototype of app and their menu
	server = new Server 'vivace', json.client.scripts, json.mountpoints
