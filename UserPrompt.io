UserPrompt := Prompt clone do(
	user := nil
	
	setUser := method(user,
		self user := user
		setChannel(user session)
		self
	)

	promptString := "> "
	
	respondTo := method(input,
		if(input == "quit",
			user session do (
				channel writeln("Goodbye.")
				close
			)
		)
	)
)