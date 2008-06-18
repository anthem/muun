TransientUserLibrary := Object clone do (
	authentication := nil

	init := method(
		self sessionSources := List clone
		self userDatabases := List clone
	)

	setAuthentication := method(auth,
		self authentication := auth
	)
	
	setSessionSource := method(source,
		self sessionSources append(source)
		source setOwner(self)
		source handleSession := method(newSession,
			self owner authentication authenticateSession(newSession) ifTrue(self owner addSession(newSession))
		)
	)
)