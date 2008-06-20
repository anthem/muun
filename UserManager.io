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
			if(list("y", "yes") contains(response asMutable lowercase)) then (
				if(self authentication confirmPassword(session, unauthorizedIdentity, "Please confirm your password: ") not,
					self authentication newPassword(session, unauthorizedIdentity, "Those passwords do not match. Please enter a new password: ", "Please confirm that password: ")
				)
				self authentication identityLibrary learn(unauthorizedIdentity)
				session channel writeln("Welcome.")
				user := User clone setIdentity(unauthorizedIdentity) setSession(session)
				objectEvent("newUserIdentity") @@announce(user)
				objectEvent("userJoined") @@announce(user)						
			) else (
				self authentication challenge(session, "What is your name, then? ")
			)
		))

		auth objectEvent("userAuthenticated") appendListener(block(identity, session, 
			objectEvent("userJoined") @announce(User clone setIdentity(identity) setSession(session))
			"Connected" println
		))

		auth objectEvent("userAuthenticationFailed") appendListener(block(unauthorizedIdentity, session, 
			unauthorizedIdentity loginAttempts := if(unauthorizedIdentity hasSlot("loginAttempts"),
				unauthorizedIdentity loginAttempts + 1,
				1)
			if(unauthorizedIdentity loginAttempts >= 3) then (
				session channel writeln("Sorry, too many login attempts.")
				session channel close
			) else (
				self authentication rechallengePassword(session, unauthorizedIdentity, "Invalid password. Please try again: ")
			)
		))
		self
	)
	
	initializeSession := method(session,
		self authentication challenge(session)
	)
)
