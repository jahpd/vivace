fs = require 'fs'
coffee = require 'coffee-script'
path = require 'path'

option '-v', '--verbose', 'verbose mode'

#a wrapper to tasks
class Vivace
	
	#typing Vivace.new options, you do a compiling process
	constructor: (options, @version='0.1') ->
		{@verbose} = options
		@display = (msg) -> if @verbose then console.log "#{msg}\n"
		@warn = (msg) -> if @verbose then console.log "!!! #{msg}\n"
		@see = (msg) -> if @verbose then console.log "--- #{msg} ---\n"
		@log = (msg) -> if @verbose then console.log "-> #{msg}\n" 	
		@display "======================="
		@display "cake vivace version #{@version}"
		@display "======================="	
	
	compile: (paths...) ->
		_path = paths[0]
		@log "get #{_path}"
		data = fs.readFileSync _path, 'utf8'
		
		#now verify if we do thing to one argument or more
		jsfilename = _path.split('.coffee')[0]
		if paths[1] 
			jsfilename = jsfilename.split('coffeescripts/')[1]
			jsfilename = "#{paths[1]}/#{jsfilename}.js"
		else
			jsfilename = "#{jsfilename}.js"
		@log "out #{jsfilename}"
		
		try
			code = coffee.compile data
			fs.writeFile jsfilename, code
		catch e
			@warn "error on #{paths[0]}"
			@see e

	read: (paths...) ->
		if paths.length == 1
			@compile "#{paths[0]}.coffee"
		else
			JSPATH = /(coffee)/
			for file in fs.readdirSync paths[0]
				if JSPATH.test file
					@compile "#{paths[0]}/#{file}", paths[1] 					 			
	app: ->
		@read './app' 
		@log "DONE"
	
	folders: (folders...) ->
		@read "./#{folders[0]}/#{folders[1]}", if !folders[2] then "./#{folders[0]}" else "./#{folders[0]}/#{folders[2]}"
		@log "DONE"
	
	routes: -> @folders 'routes', 'coffeescripts'
	client: -> @folders 'public', 'coffeescripts', 'javascripts'

task 'app', 'rebuild the Vivace application', (options) -> (new Vivace options).app()
task 'app:routes', 'rebuild the Vivace routes', (options) -> (new Vivace options).routes()
task 'app:client', 'rebuild the Vivace client scripts', (options) -> (new Vivace options).client()