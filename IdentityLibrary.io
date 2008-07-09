IdentityLibrary := Object clone do (
	init := method(
		self store := Map clone
	)

	learn := method(identity,
		self store atPut(identity key, identity)
		self
	)

	unlearn := method(identity,
		self store removeAt(if(identity hasSlot("key"), identity key, identity))
		self
	)
	
	hasKey := method(key,
		self store hasKey(key)
	)

	hasIdentity := method(identity,
		self store hasKey(identity key) and self store at(identity key) authenticatesAs(identity)
	)
	
	at := method(identity,
		self store at(if(identity hasSlot("key"), identity key, identity))
	)
)