#./menu.coffee

menu = 
	banner:
		team:[
			{name: 'aut0mata', href:'https://github.com/automata'}
			{name: 'gabiThume', href: 'https://github.com/GabiThume'}
			{name: 'jahpd', href: 'https://github.com/jahpd'} 
			{name: 'hybrid', href: 'http://github.com/'}
			]
		about:[
			{name: 'src', href: 'https://github.com/automata/vivace'}
			]
		help:[
			{name: 'using vivace'}
			{name: 'soundcloud authentication'}
			{name: 'enabled variables'}
			]
		ui:[
			{name: 'using vivace ui for mixing'}
			]
			
	create: (css, o, callback) ->
		c = () ->
			if $(this).children().is ':visible'
				$(this).children().hide '200'
			else
				$(this).children().show '200'
		
		# the graphical menu
		Vivace.menu.ui = $(css).click(c).addClass 'ban'
		
		$.each o, (k, v) ->
			#get the vivace menu and add click handler
			Vivace.menu.ui[k] = $('<ul/>').html(k).addClass('ban').click c
			
			#put an html link
			$.each v, (i, e) ->
				href = e['href'] || '#'
				name = e['name'] || 'DEFAULT_NAME'
				callbackFunc = e['callback'] || false
				
				Vivace.menu.ui[k].item = $('<li/>')
				Vivace.menu.ui[k].itemlink= $('<a/>').html(e['name']).attr('href', href)
				
				if callbackFunc 
					Vivace.menu.ui[k].itemlink.click callbackFunc
					
				Vivace.menu.ui[k].append(Vivace.menu.ui[k].link).appendTo $ul
			
			$ul.appendTo(Vivace.menu.ui).hide 'slow'
			callback(k)
		return 

#expose
window.Vivace.menu = menu