/*
Session wraps the channel of communication to a client and should behave like a Socket.
*/
Session := Object clone do (
	channel := nil
	
	withSession := method(session,
		setChannel(session channel)
		self appendProto(session)
	)

	withChannel := method(channel,
		self clone setChannel(channel)
	)
	
	setChannel := method(channel,
		self channel := channel
		self
	)
	
	forward := method(
		call delegateTo(self channel, call sender)
	)
)
