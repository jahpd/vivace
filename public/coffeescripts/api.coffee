# ./vivace.coffee
# construct Vivace API Object
Vivace = {}

#environment of all possibles namespaces
Vivace.environment = [
	{name: 'a', fileName: 'kick.wav', type: 'audio'}
	{name: 'b', fileName: 'dj.wav', type: 'audio'}
    {name: 'c', fileName: 'snare.wav', type: 'audio'}
    {name: 'd', fileName: 'hihat.wav', type: 'audio'}
	{name: 'i', fileName: 'illuminatti.mp4', type: 'video'}
];

#events of each name
Vivace.events = 
	id:[]
	currentbeat:[]
	nextbeat:[]
	push: (o) -> $.each o, (k, v) -> if k == 'id' or  k == 'currentbeat' or  k == 'nextbeat' then Vivace.events[k].push v
			
# Active voices
Vivace.voices = {};
Vivace.lastVoices = null;

#add variable to environment dynamically
#(i.e, when we can have some support to automatcally download and upload)
Vivace.addToEnv = (n, fn, t) -> Vivace.environment.push {name: n, fileName: fn, type: t}

Vivace.beats = 0;
Vivace.bpm = 120; 							# 120 seminimas per minute
Vivace.minimalUnity = m = Vivace.bpm * 4; 	# we tick at each 960 seminimas (or, 1 semifusa) 
											#change 8:semifusa 4:fusa 2:colcheia 1:seminima as the minor unity
Vivace.timeInterval = m / m * 1000; 		# so, at each 62.5 ms we tick 
Vivace.semiBreve = 32  						#one semibreve is equal to 64 semifusas (hemidemisemiquaver) (or 32 fusas)
											#change 64:semifusa 32:fusa 16:colcheia 8:seminima

#http://creativejs.com/resources/web-audio-api-getting-started/
if typeof AudioContext != "undefined" 
	Vivace.audiocontext = new AudioContext() 
else if typeof webkitAudioContext != "undefined"
    Vivace.audiocontext = new webkitAudioContext()
else
	throw new Error 'AudioContext not supported.'
    
Vivace.isRunning = false

Vivace.onload = (src, callback) ->
	folder='javascripts/vivace/'
	start = {}
	$('body').ready () ->
		$script = $('<scr'+'ipt/>').attr 'type', 'text/javascript'
		$script.attr 'src', folder+src+'.js'
		$('body').append $script
		callback()
	
window.Vivace = Vivace	