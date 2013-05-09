# soundcloud.cofee is part of Vivace environment
# for any help, see http://developers.soundcloud.com/docs

if (window.SC != undefined)
	Vivace.soundcloud = 
		root: null
		users: {}
		initialize: () -> window.SC.initialize {client_id: 'YOUR_CLIENT_ID', redirect_uri: 'REDIRECT_URL'}
		connect: () -> window.SC.get '/me', (me) -> 
			console.log 'soundcloud '+me.username+' using Vivace'
			Vivace.users[me.username] = 
				url: () -> 'http://soundcloud.com/'+me.username+'/'
				trackname_url: (trackname)  -> url() + trackname