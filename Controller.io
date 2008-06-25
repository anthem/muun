/*
Controller is an abstract class that represents any system capable of accepting the role of controlling an world entity.
All active world entities have a controller of some sort that defines its behavior. Those without entities are passive.
*/
Controller := Object clone do (
	// a controller needs a globally unique ID so it can be distingushed from all other controllers
	// in order to receive and send events
)