/*
RestrictedDataStore acts as a broker of information to which only those
identities previously authorized may have access.
*/
RestrictedDataStore := Object clone do (
	setAccessControl := method(accessLevel,
		self accessControl := accessLevel
		return self
	)
	
	accessControl := method(
		return self accessControl
	)
	
	obtainResource(identity)
)


Resource := Object clone do (
	setData := method(data,
		self data := data
		
	)
)