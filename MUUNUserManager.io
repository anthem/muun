MUUNUserManager := Object clone do (
	setSource := method(source,
		self source := source

		source objectEvent("newSession") appendListener(block(socket, 
			initializeSession(socket)
		))
		self
	)
	
	setAuthentication := method(auth,
		self authentication := auth
		self authentication objectEvent("sessionAuthenticated") appendListener(block(identity,
			"Connected" println
		))
		self authentication objectEvent("identityUnknown") appendListener(block(identity,
			"Unknown" println
		))
		self authentication objectEvent("authenticationFailure") appendListener(block(identity,
			"Failed" println
		))
		self
	)
	
	initializeSession := method(session,
		self authentication challenge(session)
	)
)
