fs = require 'fs'
express = require 'express'
sharejs = require 'share'
path = require 'path'
	
		

# with @bind we can attach some custom functions
VivaceServer::bind = (name, func) -> this[name]=func

exports.Server = VivaceServer