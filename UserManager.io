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
				if(authentication confirmPassword(session, unauthorizedIdentity, "Please confirm your password: ") not,
					authentication newPassword(session, unauthorizedIdentity, "Those passwords do not match. Please enter a new password: ", "Please confirm that password: ")
				)
				authentication identityLibrary learn(unauthorizedIdentity)
				session channel writeln("Welcome.")
				user := User clone setIdentity(unauthorizedIdentity) setSession(session)
				objectEvent("newUserIdentity") @@announce(user)
				objectEvent("userJoined") @@announce(user)						
			) else (
				authentication challenge(session, "What is your name, then? ")
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
				authentication rechallengePassword(session, unauthorizedIdentity, "Invalid password. Please try again: ")
			)
		))
		self
	)
	
	setBanner := method(bannerStr,
		self banner := bannerStr
	)
	
	initializeSession := method(session,
		if(hasSlot("banner"), session channel writeln(banner))
		authentication challenge(session)
	)
)
