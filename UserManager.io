UserManager := Object clone do (
	appendProto(ObjectEventSource)
	addObjectEvent("userJoined")
	addObjectEvent("newUserIdentity")
	
	setSource := method(source,
		self source := source
		source objectEvent("newSession") appendListener(block(session, 
			initializeSession(UserSession withSession(session))
		))
		self
	)
	
	setAuthentication := method(auth,
		self authentication := auth
		auth objectEvent("unknownUserIdentity") appendListener(block(unauthorizedIdentity, session,
			session channel write("I don't think I know you. Are you new here (y/n)? ")
			response := session channel readLine
			if(response == "yes") then (
				session channel write("Please confirm your password, then: ")
				userIdentity := UserIdentity clone withUsernameAndPassword(unauthorizedIdentity username, session channel readLine)
				if(user encryptedPassword == unauthorizedIdentity encryptedPassword) then (
					self authentication learn(userIdentity)
					session channel writeln("Welcome.")
					user := User clone setIdentity(userIdentity) setSession(session)
					objectEvent("newUserIdentity") @announce(user)
					objectEvent("userJoined") @@announce(user)
				) else (
					session channel writeln("That password doesn't match.")
					self authentication challenge(session)
				)
			) else (
				session channel writeln("What is your name, then? ")
				self authentication challenge(session)
			)
		))

		auth objectEvent("userAuthenticated") appendListener(block(identity, session, 
			objectEvent("userJoined") @announce(User clone setIdentity(identity) setSession(session))
			"Connected" println
		))

		auth objectEvent("userAuthenticationFailed") appendListener(block(unauthorizedIdentity, session, 
			"Failed" println
		))
		self
	)
	
	initializeSession := method(session,
		self authentication challenge(session)
	)
)
