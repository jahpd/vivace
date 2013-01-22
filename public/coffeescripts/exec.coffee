exec = (input) ->
	tree = vivace.parse(input);
	definitions = tree.code.definitions;

	// go to all definitions again and update voices details
	voiceNames=[]
	for definition in definitions
		voiceName = definition.name.val;
		voiceNames[voiceName]=true;
		if definition.attr.val == 'sig'
			if definition.is.type === 'chains'
				// for now, just dealing with audio('id') and video('id')
				if definition.is.val[0].name.val === 'audio'
					voices[voiceName].sig = definition.is.val[0].parameters[0].val
					voices[voiceName].sigType = 'audio'
				else if (definitions[i].is.val[0].name.val === 'video'
					voices[voiceName].sig = definition.is.val[0].parameters[0].val
					voices[voiceName].sigType = 'video'
		// amp
		else if definition.attr.val === 'amp'
			// [ ]
			if definition.is.type === 'values'
				amp = []
				for (var j=0; j<definitions[i].is.val.length; j=j+1) {
					amp.push(definitions[i].is.val[j].val);
				}
				voices[voiceName].amp = amp.reverse();
				// { }
			} else if (definitions[i].is.type === 'durations') {
				var dur = [];
				for (var j=0; j<definitions[i].is.val.length; j=j+1) {
					dur.push(definitions[i].is.val[j].val);
				}
				voices[voiceName].dur = dur.reverse();
			}
			// pos
		} else if (definitions[i].attr.val === 'pos') {
			// [ ]
			if (definitions[i].is.type === 'values') {
				var pos = [];
				for (var j=0; j<definitions[i].is.val.length; j=j+1) {
					pos.push(definitions[i].is.val[j].val);
				}
				voices[voiceName].pos = pos.reverse();
				// { }
			} else if (definitions[i].is.type === 'durations') {
				var dur = [];
				for (var j=0; j<definitions[i].is.val.length; j=j+1) {
					dur.push(definitions[i].is.val[j].val);
				}
				voices[voiceName].dur = dur.reverse();
			}
			// gdur
		} else if (definitions[i].attr.val === 'gdur') {
			// [ ]
			if (definitions[i].is.type === 'values') {
				var gdur = [];
				for (var j=0; j<definitions[i].is.val.length; j=j+1) {
					gdur.push(definitions[i].is.val[j].val);
				}
				voices[voiceName].gdur = gdur.reverse();
				// { }
			} else if (definitions[i].is.type === 'durations') {
				var dur = [];
				for (var j=0; j<definitions[i].is.val.length; j=j+1) {
					dur.push(definitions[i].is.val[j].val);
				}
				voices[voiceName].dur = dur.reverse();
			}
		}
	}
	return [voices,voiceNames];
}