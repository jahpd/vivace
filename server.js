console.log('Vivacelang running...');

var express = require('express'),
	sharejs = require('share'),
	server = sharejs.server,
	path = require('path'),
	routes = require('./routes'),
	app = express();

//attach the sharejs REST and Socket.io interfaces to the server
var options = {db: {type: 'none'}};
server.attach(app, options);

app.configure(function(){
	app.set('views', __dirname + '/views');
	app.set('view engine', 'jade');
	app.use(express.favicon());
	app.use(express.logger('dev'));
	app.use(express.bodyParser());
	app.use(express.methodOverride());
	app.use(app.router);
	app.use(require('stylus').middleware(__dirname + '/public'));
	app.use(express.static(path.join(__dirname, 'public')));
});

app.configure('development', function(){
	app.use(express.errorHandler());
});

app.get('/', routes.index);

var port = 5000;
app.listen(port);

console.log('at http://127.0.0.1 port '+port);

