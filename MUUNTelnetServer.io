MUUNTelnetServer := Server clone do (
	appendProto(ObjectEventSource)
	addObjectEvent("newSession")

	handleSocket := method(aSocket,
		objectEvent("newSession") @@announce(TelnetSession withChannel(aSocket))
	)
)
