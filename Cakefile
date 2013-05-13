tasks = require './routes/task'

option '-v', '--verbose', 'verbose mode'

task 'app', 'rebuild the Vivace application', (options) -> 
	t = new tasks.Cake options
	t.app();
	
task 'app:routes', 'rebuild the Vivace routes', (options) ->
	t = new tasks.Cake options
	t.routes();
		
task 'app:client', 'rebuild the Vivace client scripts', (options) ->
	t = new tasks.Cake options
	t.client()