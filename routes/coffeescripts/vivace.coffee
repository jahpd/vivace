server = require './routes/utils'

# with @bind we can attach some custom functions
server::bind = (name, func) -> this[name]=func

###
# create a simple server with:
	- name
	- async client scripts response
	- static menu
		- title
		- link reference
		- client code response for that link reference
###
module.exports = () ->
	folder = "public/javascripts"
	clientScripts = "#{folder}/#{script}.js" for file in fs.readdir folder
	new server 'vivace', clientScripts, menu = 
		log:
			title: 'log'
			href: '/log'
			code: 'login.username =\nlogin.password ='
		developers:
			title: 'devLOOPERS'
			href: '/developers'
			code: 'developer =\ngithub.at "vivace", developer'
		help:
			title: 'help'
			href: '/help'
			code: 'help.usage()'