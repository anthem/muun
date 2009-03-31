Challenge := Object clone do (
	//doc challenge returns the identity if successful, or nil
	challenge := method(session,
		return nil
	)
)

TextPasswordChallenge := Challenge clone do (
	authentication ::= nil

	//doc challenge the session by displaying username and password prompts.
	challenge := method(session,
		identity := PasswordIdentity clone
		usernamePrompt := "Username: "
		usernameCorrect := false
		while(usernameCorrect not,
			readUsername(session, identity, usernamePrompt)
			if(authentication authenticate(identity) == nil) then (
				newIdentity := handleUnknownIdentity(session, identity)
				if(newIdentity == nil) then (
					usernamePrompt := "What is your name, then? "
				) else (
					usernameCorrect := true
					return identity
				)
			) else (
				usernameCorrect := true
				return handleKnownIdentity(session, identity)
			)
		)
	)
	
	readUsername := method(session, identity, prompt,
		session channel write(prompt)
		if(username := session channel readln,
			identity setUsername(username)
		)
	)
	
	handleKnownIdentity := method(session, identity,
		loginAttemptsLeft := 3
		readPassword(session, identity, "Password: ")
		authenticated := authentication authenticate(identity)
		while(authenticated == false and loginAttemptsLeft > 0,
			loginAttemptsLeft := loginAttemptsLeft - 1
			readPassword(session, identity, 
				"That's not the right password. I'll give you #{loginAttemptsLeft} more tries: " interpolate)
			authenticated := authentication authenticate(identity)
		)
		if(authenticated not) then (
			session channel writeln("Sorry, too many login attempts.")
			session close
			return nil
		) else (
			handleIdentityAuthenticated(session, identity)
			return identity
		)
		
	)

	readPassword := method(session, identity, prompt,
		session channel write(prompt)
		if(password := session channel readln,
			identity setPassword(password)
		)
	)

	handleUnknownIdentity := method(session, identity,
		session channel write("I don't think I know you. Are you new here (y/n)? ")
		response := session channel readln
		pwPrompt := "Please choose a password: "
		if(list("y", "yes") contains(response asMutable lowercase)) then (
			confirmed := false
			while(confirmed not,
				readPassword(session, identity, pwPrompt)
				confirmed := confirmPassword(session, identity, "Please confirm your password: ")
				if(confirmed not,
					pwPrompt := "Those passwords do not match. Please enter a new password: "
				)
			)
			authentication store insert(identity)
			session channel writeln("Welcome.")
			return identity
		) else (
			return nil
		)
	)
	
	confirmPassword := method(session, identity, prompt,
		session channel write(prompt)
		password := session channel readln
		return identity clone setPassword(password) authenticatesAs(identity)
	)

	handleIdentityAuthenticated := method(session, identity, 
		return identity
	)
)