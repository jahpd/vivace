fs = require 'fs'
Server = require('./utils').Server

###
# create a simple server with:
	- name
	- async client scripts response
	- static menu
		- title
		- link reference
		- inner link sugar codes!
###
module.exports = () ->
	folder = "public/javascripts"
	clientScripts = "#{folder}/#{file}.js" for file in fs.readdir folder
	new Server 'vivace', clientScripts, menu = 
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