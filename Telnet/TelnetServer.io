TelnetServer := Server clone do (
	sessionManager ::= nil

	handleSocket := method(aSocket,
		sessionManager @@manageSession(TelnetSession clone setChannel(aSocket))
	)
)
