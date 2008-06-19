UserSession := Session clone do(
	UserSessionExtensions := Object clone do (
		readLine := method(
			readUntilSeq("\n") asMutable strip
		)
		writeln := method(
			self doMessage(Message clone setName("write") setArguments(call message arguments))
			self write("\r\n")
		)
	)

	setChannel := method(channel,
		UserSessionExtensions slotNames foreach(name,
			if(channel hasLocalSlot(name) not,
				channel setSlot(name, UserSessionExtensions getSlot(name))
			)
		)
		resend
	)
)
