ObjectEventSource := Object clone do (
	addObjectEvent := method(name,
		self getSlot("events") ifNil(self events := Map clone)
		self events atIfAbsentPut(name, ObjectEvent clone setName(name))
		return self
	)
	
	removeObjectEvent := method(name,
		self getSlot("events") ifNil(return) removeAt(name)
	)
	
	objectEvent := method(name,
		self events ifNil(return nil) at(name)
	)
)

