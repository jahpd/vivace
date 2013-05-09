#our stored sketchs
# TODO make a mongodb database for sketchs...
Vivace.updateSketch = (setup, draw) ->
	Vivace.runningSketch.setup = setup
	Vivace.runningSketch.draw = draw
	Vivace.runningSketch