/*
User encapsulates the concept of a "user" as an entity and that entity's
associated application-specific data which may persist across sessions.
*/

User := Object clone do (
	username := "Unnamed"

	init := method(
		self data := RestrictedDataStore clone
		self name
	)
	
	setPassword := method(unencrypted,
		self encryptedPassword := MD5 clone appendSeq(unencrypted) md5String
	)
)