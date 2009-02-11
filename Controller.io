/*
Controller is an abstract class that represents any system capable of
accepting the role of controlling an entity.
All active world entities have a
controller of some sort that defines its behavior.
Those entities without controllers are passive and cannot act on their own
unless a controller takes control of them.
*/
Controller := Object clone do (
	init := method(
		self identity := UUIDIdentity clone
		self entity := nil
		setNextThink
	)
	
	setEntity := method(entity,
		prev = self entity
		self entity := entity
		if(self entity != entity, entityChanged)
	)
	
	entityChanged := method(
	)
	
	setNextThink := method(
	)
	
	think := method(
	)
)
