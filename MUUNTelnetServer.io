MUUNTelnetServerSession := Object clone do (
	appendProto(UserSource)

	handleSocketFromServer := method(aSocket, aServer,
		aServer getSlot("handleSession") call(aSocket, aServer)
	)
)

MUUNTelnetServer := Server clone do (
	appendProto(ObjectEventSource)
	addObjectEvent("newSession")
	
	handleSession := block(aSocket, aServer,
		Exception raise("Slot 'handleSession' not overridden.")
	)

	handleSocket := method(aSocket,
		objectEvent("newSession") @announce(aSocket)
	)
)
