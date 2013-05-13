fs = require 'fs'
coffee = require 'coffee-script'

#a wrapper to tasks like read, write and compile files
class Task
		
	#typing Vivace.new options, you do a compiling process
	constructor: (options, @name, @version='0.1') ->
		{@verbose} = options
		@display = (msg) -> if @verbose then console.log "#{msg}\n"
		@log = (msg) -> if @verbose then console.log "-> #{msg}\n"
		@warn = (msg) -> if @verbose then console.log "!!! #{msg}\n"
		@err = (msg) -> if @verbose then console.log "--- #{msg} ---\n" 	
		@display "======================="
		@display "#{@name} - v. #{@version}"
		@display "======================="	
		
	#generate a string of file to any folder
	_2folder: (f, file) -> "#{f}/#{file}"
	
	#generate a string of file with any extension
	filedottext: (file, extension)-> "#{file}.#{extension}"
	
	#generate a string of file with extension coffee
	asCoffee: (file)-> @filedottext file, 'coffee'
	
	#generate a string of file with extension coffee
	asJs: (file)-> @filedottext file, 'js'
	
	#generate a string of file reference in parent folder 
	_2parentFolder: (folders) -> 
		path = ""
		path += "#{folder}/" for folder in folders when _i isnt folders.length-2
	
	these: (path, callback) ->  callback  p for p in path.split '/' when (/\//).test path 
	
	#get files content
	readfile: (path) -> fs.readFileSync path, 'utf8'
	
	writefile: (path, data) -> fs.writeFile path, data
	
	#swap folder change a string of paths
	swap_ext: (path) ->
		jsfilename = path.split(".coffee")[0]
		"#{jsfilename}.js"
	
#to be used in Cake file only
class Cake extends Task
	construtor: (options, @name="vivace cake task") ->
	
	process: (options, callback) ->
		for data in options.datas
			paths =
				in: options.inpaths[_i]
				out: options.outpaths[_i]	
			try
				code = coffee.compile data
				callback null, code , paths 
			catch e
				callback e, null, paths

	compile: (options) ->
		options.inpaths = []
		options.datas = []
		options.outpaths = []
		
		if options.input and !options.output
			options.inpaths.push  @asCoffee options.input
			options.datas.push @readfile options.inpaths[0]
			options.outpaths.push @swap_ext options.inpaths[0]
		else	  
			for file in fs.readdirSync options.input
				options.inpaths.push @_2folder options.input, file
				options.datas.push @readfile options.inpaths[_i]
				options.outpaths.push @swap_ext "#{options.output}/#{file}"
				  
		@process options, (err, data, paths) => 
			if !err 
				@log "get #{paths.in}"
				#@warn "compiled code:\n#{data}"
				@writefile paths.out, data
				@log "out #{paths.out}"
			else
				@warn "error on compile #{paths.in} to #{paths.out}"
				@err err
				
	app: ->
		@compile {
			input: './app'
		}
		@log "DONE"
		
	routes: -> 
		@compile {
			input: './routes/coffeescripts'
			output: './routes'
		}
		@log "DONE"
		
	client: ->
		@compile {
			input: './public/coffeescripts'
			output:  './public/javascripts'
		}
		@log "DONE"

exports.Task = Task
exports.Cake = Cake