UserSession := Session clone do(
	UserSessionExtensions := Object clone do (
		readLine := method(
			readUntilSeq("\n") asMutable strip
		)
		writeln := method(
			self performWithArgList("write", call message argsEvaluatedIn(call sender))
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
