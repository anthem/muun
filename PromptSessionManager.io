/*
PromptSessionManager defines the stages and states that a PromptSession
progresses through during its time on the server.

setBanner : set any initial text that is send to the session's channel before
	challenging for authentication
setShellPrompt : sets the initial ("shell") Prompt that will be set for the session
setChallenge : set the Challenge mechanism for managed sessions
manageSession(session) : starts management process for Session

Events:
challengeAccepted(session, identity) : challenge on session has been accepted
	with identity and prompts have been initialized
challengeRejected(session) : challenge failed for session; session will be closed
*/

PromptSessionManager := Object clone do(
	PromptSessionHandler := Object clone do (
		session ::= nil
		manager ::= nil
		
		withSessionAndManager := method(sess, mgr,
			sess appendProto(PromptSession)
			self clone setSession(sess) setManager(mgr)
		)

		start := method(
			manager showBanner(session)
			if((identity := manager challenge challenge(session)) != nil) then (
				self sessionClosed := block (onSessionClose)
				session closeEvent appendObserver(self sessionClosed)
				session pushPrompt(manager shellPrompt clone setSession(session))
				session @@startPrompt
				manager challengeAccepted notifyObservers(session, identity)
			) else (
				manager challengeRejected notifyObservers(session)
				session close
			)
		)
		
		onSessionClose := method(
			manager sessions remove(session)
			"Quit. Now #{manager sessions size} sessions" interpolate println
			session closeEvent removeObserver(self sessionClosed)
		)
	)
	
	appendProto(Observable)
	
	banner ::= ""
	shellPrompt ::= nil
	challenge ::= nil
	sessions := List clone
	
	init := method(
		addObservation(challengeAccepted, challengeRejected)
		self sessions := List clone
	)
	
	removeSession := method(sess,
		sessions remove(sess)
		"#{sessions size} sessions active." interpolate println
	)

	manageSession := method(session,
		sessions append(session)
		"#{sessions size} sessions active." interpolate println
		PromptSessionHandler withSessionAndManager(session, self) @@start
	)

	showBanner := method(session,
		session channel writeln(banner)
	)
)	
