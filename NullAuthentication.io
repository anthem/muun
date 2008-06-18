/*
NullAuthentication - Grants access to everything for everything without challenge
*/
NullAuthentication := Object clone do (
	authenticate := method(identity, token,
		return true
	)
)