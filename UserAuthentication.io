UserAuthentication := Object clone do (
	appendProto(Authentication)
	appendProto(ObjectEventSource)
	addObjectEvent("unknownUserIdentity")
	addObjectEvent("userAuthenticationFailed")
	addObjectEvent("userAuthenticated")

	encrypt := method(pw, MD5 clone appendSeq(pw) md5String)
	
	greet := method(session,
		if(hasSlot("banner"), session channel writeln(banner))
	)
	
	challenge := method(session,
		usernamePrompt := if(call message arguments size >= 2, call evalArgAt(1), "Username: ")
		passwordPrompt := if(call message arguments size >= 3, call evalArgAt(2), "Password: ")
		unauthenticatedIdentity := UserIdentity clone
		session channel write("Username: ")
		if(username := session channel readLine,
			unauthenticatedIdentity setUsername(username)
			session channel write("Password: ")
			if(password := session channel readLine,
				unauthenticatedIdentity setPassword(password)
				authenticateAndDispatch(session, unauthenticatedIdentity)
			)
		)
	)
	
	authenticateAndDispatch := method(session, unauthenticatedIdentity,
		authResult := authenticate(unauthenticatedIdentity)
		if(authResult == nil,
			objectEvent("unknownUserIdentity") @@announce(unauthenticatedIdentity, session),
			if(authResult == false,
				objectEvent("userAuthenticationFailed") @@announce(unauthenticatedIdentity, session),
				objectEvent("userAuthenticated") @@announce(authResult, session)
			)
		)
		authResult
	)
	
	authenticate := method(identity,
		if(self identityLibrary hasKey(identity username),
		 	if(identityLibrary at(identity username) authenticatesAs(identity),
				identityLibrary at(identity username),
				false
			),
			nil
		)
	)
	
	newPassword := method(session, identity,
		match := false
		while(match not,
			prompt := if(call message arguments size >= 3, call evalArgAt(2), "New password: ")
			confirmPrompt := if(call message arguments size >= 4, call evalArgAt(3), "Confirm password: ")
			session channel write(prompt interpolate)
			password := session channel readLine
			newIdentity := identity clone setPassword(password)
			match := confirmPassword(session, newIdentity, confirmPrompt)
		)
		return newIdentity
	)
	
	confirmPassword := method(session, identity,
		prompt := if(call message arguments size >= 3, call evalArgAt(2), "Confirm password: ")
		session channel write(prompt interpolate)
		password := session channel readLine
		return identity clone setPassword(password) authenticatesAs(identity)
	)
	
	rechallengePassword := method(session, oldIdentity,
		prompt := if(call message arguments size >= 3, call evalArgAt(2), "Password: ")
		session channel write(prompt interpolate)
		unauthenticatedIdentity := oldIdentity clone setPassword(session channel readLine)
		authenticateAndDispatch(session, unauthenticatedIdentity)
	)
	
	
	setBanner := method(bannerStr,
		self banner := bannerStr
	)
)