/*
NameIdentity implements a simple (insecure) authentication identity whose key
is a single string (name). The identity is authenticated if names/keys match.
*/
NameIdentity := AuthenticationIdentity clone do (
	name ::= ""

	withName := method(name,
		self clone setKey(name)
	)
	
	authenticatesAs := method(other,
		self name == other name
	)
	
	key := method(
		name
	)
	
	setKey := method(name,
		self name := name
		self
	)
)