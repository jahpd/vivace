

###
Provider = (dbName, db) ->
	this.name = dbName
	this.db = db
	
	this.insert = (name, data, callback) ->
		this.db[name] =
			id: this.db.length or 0
			born: new Date(),
			data: data
		console.log "added #{name} to #{this.name}"
		callback null,  this.db[name]
		
	this.remove = (id, callback) -> 
		delete this.db[name] if stack._id==id for stack in this.db
		callback null, this.db
	
	this.display = (name) -> this.db[name]
	this.data = (name) -> this.db[name].data
	this

exports.UserProvider = UserProvider = new Provider 'User', {}
exports.JsonProvider = JsonProvider = new Provider 'Json', {}

#create dummy user
UserProvider.insert "dummy", {nick: "_duMMy_", comments: "dummy user created to test dummybase"}, (err, data) -> console.log data
JsonProvider.insert "default", { 
	title: 'Vivace'
	menu: [
		{name: 'help', href: '/help', text: 'Using vivace'}
		{name: 'developers', href: '/developers', text: 'Vivace developers'}
	]
	scripts:[]
	style: []
}, (err, data) ->
	console.log data
	
###
