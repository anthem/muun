UserAuthentication := Object clone do (
	appendProto(Authentication)
	appendProto(ObjectEventSource)
	addObjectEvent("identityUnknown")
	addObjectEvent("authenticationFailure")
	addObjectEvent("sessionAuthenticated")

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
		session write("Username: ")
		if(username := session readUntilSeq("\n") asMutable strip,
			unauthenticatedIdentity setUsername(username)
			session write("Password: ")
			if(password := session readUntilSeq("\n") asMutable strip,
				unauthenticatedIdentity setPassword(password)
				unauthenticatedIdentity println
				identity := self authenticate(unauthenticatedIdentity)
				if(nil == identity,
					objectEvent("identityUnknown") announce(unauthenticatedIdentity),
					if(identity == false,
						objectEvent("authenticationFailure") announce(unauthenticatedIdentity),
						objectEvent("sessionAuthenticated", identity) announce(unauthenticatedIdentity)
					)
				)
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