/*
The MUUN object is the master controller that organizes the individual components.
*/
MUUN := Object clone do (
 	init := method(
		// persistent data sources
		self userSources := List clone
		self objectLibraries := List clone
		
		// transient data
		self users := List clone
		self objects := List clone
	)
	
	run := method(
	)
	
	addObjectLibrary := method(library,
		1
	)
	
	addUserSource := method(source,
		source handleUser := method(user, userSource,
			users append(user)
		)
	)
)