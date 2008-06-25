ControllerManager := Object clone do (
	init := method(
		self sources := List clone
	)
	
	addControllerSource := method(source,
		self sources append(source)
	)
)
