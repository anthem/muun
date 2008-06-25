/*
The MUUN object is the master controller that organizes the individual components.
*/


MUUN := Object clone do (
 	init := method(
		self controllerSources := List clone
		self world := Object clone
	)
	
	setWorld := method(world,
		nil
	)
	
	addControllerSource := method(source,
		self controllerSources append(source)
	)
	
	start := method(
		while(true,
			// read events from controller and enact them within the world
			// receive events from the world and enact them on the target controllers
			nil
		)
	)
)