/*
Library is a generic collection proto for objects that provide the 'key' slot
returning a unique identifier.
*/

Library := Object clone do (
	//doc Store must implement a Map interface
	store ::= nil
	
	//doc init Initializes the Library with an empty store.
	init := method(
		setStore(Map clone)
	)

	//doc insert Storage a given object or overwrites an existing object with the same key.
	insert := method(entry,
		self store atPut(entry key, entry)
		self
	)

	//doc remove Removes a stored object with the same key, or removes the object itself.
	remove := method(entry,
		self store removeAt(if(entry hasSlot("key"), entry key, entry))
		self
	)
	
	//doc hasKey returns true or false indicating whether the key has been stored already.
	hasKey := method(key,
		self store hasKey(key)
	)

	//doc at Returns the entry identified by key.
	at := method(entry,
		self store at(if(entry hasSlot("key"), entry key, entry))
	)
	
	forward := method(
		call delegateTo(store)
	)
)