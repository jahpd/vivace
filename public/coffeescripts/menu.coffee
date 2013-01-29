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
		$vivacemenu = $(css).click(c).addClass 'ban'
		$.each o, (k, v) ->
			#get the vivace menu and add click handler
			$div = $('<ul/>').html(k).addClass('ban').click c
			#put an html link
			$.each v, (i, e) ->
				href = e['href'] || '#'
				$a = $('<a/>').html(e['name']).attr('href', href)
				$('<li/>').append($a).appendTo $div
			
			$div.appendTo($vivacemenu).hide 'slow'
			callback(k)
		return 

#expose
window.Vivace.menu = menu