IdentityLibrary := Map clone do (
	init := method(
		super(init)
	)

	learn := method(identity,
		atPut(identity key, identity)
		self
	)

	unlearn := method(identity,
		removeAt(if(identity hasSlot("key"), identity key, identity asString))
		self
	)
	
	hasIdentity := method(identity,
		hasKey(identity key) and identity authenticatesAs(at(identity key))
	)
)