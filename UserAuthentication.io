UserAuthentication := Object clone do (
	appendProto(Authentication)
	appendProto(ObjectEventSource)
	addObjectEvent("unknownUserIdentity")
	addObjectEvent("userAuthenticationFailed")
	addObjectEvent("userAuthenticated")

	encrypt := method(pw, MD5 clone appendSeq(pw) md5String)
	
	learn := method(identity,
		users atPut(identity username, identity)
		self
	)
	
	unlearn := method(identity,
		user := if(identity hasSlot("username"), identity username, identity)
		users removeAt(user)
		self
	)
	
	challenge := method(session, 
		unauthenticatedIdentity := UserIdentity clone
		session channel write("Username: ")
		if(username := session channel readLine,
			unauthenticatedIdentity setUsername(username)
			session channel write("Password: ")
			if(password := session channel readLine,
				unauthenticatedIdentity setPassword(password)
				authResult := authenticate(unauthenticatedIdentity)
				if(authResult == nil,
					objectEvent("unknownUserIdentity") @announce(unauthenticatedIdentity, session),
					if(authResult == false,
						objectEvent("userAuthenticationFailed") @announce(unauthenticatedIdentity, session),
						objectEvent("userAuthenticated") @announce(authResult, session)
					)
				)
				authResult
			)
		)
	)
	
	authenticate := method(identity,
		if(self users hasKey(identity username),
		 	if(self users at(identity username) authenticatesAs(identity),
				users at(identity username),
				false
			),
			nil
		)
	)
	
	init := method(
		self users := Map clone
	)
	
	
	//doc adds the users in the users as recognized users.
	// any conflicts are resolved by using the most recently added information.
	addUsers := method(users,
		self users addKeysAndValues(users keys, users values)
	)
)