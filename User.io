/*
User encapsulates the concept of a "user" as an entity with an identity and
with a means of communication (Session)
*/

User := Object clone do (	
	init := method(
		self identity := nil
		self session := nil
	)
	
	setIdentity := method(identity,
		self identity := identity
		self
	)
	
	setSession := method(session,
		self session := session
		self
	)
)