fs = require 'fs'
coffee = require 'coffee-script'

option '-o', '--output [DIR]', 'directory for compiled code'
option '-c', '--compile [DIR]', 'compile code from here'
option '-p', '--pole [DIRS...]', 'a version from -c, but with multiple directories; \n\tWARNING: you MUST use -po argument'
option '-po', '--pole_output [DIRS...]', 'used with -p'
option '-v', '--verbose', 'verbose mode'

class Vivace
	constructor: (@options) -> 
		@verbose = (msg) -> @options.verbose ? console.log msg
		@input = @options.pole ? @options.compile ? './'
		@output = @options.pole_compile ? @options.compile ? './'
		@normpath = (dir, file)-> dir=="./"?dir:"#{dir}/"
		@write = (dir, file, code)-> fs.writeFile "#{dir}{file}.js", code
	
	readFiles: (dir, callback) ->callback file for file in dir for dir in fs.readdir "./#{dir}"
	go: -> @readFiles @input, (dir, file) -> @code dir, file
	go2: -> (@readFiles input, (dir, file) -> @code dir, file) for input in @inputs
	modules: ->
		@verbose "<======================>"
		@verbose "compiling vivace modules..."	
		codes = if typeof @input is 'string' then @go() else @go2
		@verbose codes
		if typeof inputs is 'string' then @write @input else @write() for input in inputs
		@verbose "<======================>"
		
	app: ->
		@verbose "<======================>"
		@verbose "compiling vivace app..."
		fullpath = @normpath @input, 'app'
		@verbose "parsing  #{fullpath}"
		code = coffee.compile fullpath
		@verbose "#{code}"
		dir = @options.output ? './'
		@write dir, 'app', code
		@verbose "DONE #{fullpath}"
		@verbose "<======================>"
	
task 'app', 'rebuild the Vivace application', (options) -> (new Vivace options).app()
task 'modules', 'rebuild the Vivace modules', (options) -> (new Vivace options).modules()	