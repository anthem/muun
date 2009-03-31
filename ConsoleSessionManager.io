ConsoleSessionManager := Object clone do (
	appendProto(Observable)
	
	challenge ::= nil
	session ::= nil
	
	init := method(
		addObservation(challengeAccepted)
	)

	start := method(
		loop (
			setSession(ConsoleSession clone)
			if((identity := challenge challenge(session)) != nil,
				challengeAccepted notifyObservers(session, identity)
			)
		)
	)
)