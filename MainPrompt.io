MainPrompt := Object clone do(
	active := false
	user ::= nil

	activate := method(
		self active := true
		user session writeln("Main menu:")
		while(active,
			prompt
		)
	)
	
	deactivate := method(
		self active := false
		user session writeln("Leaving main menu.")
	)
	
	prompt := method(
		user session write("> ")
		line := user session readln
		user session writeln("You wrote: #{line}" interpolate)
	)
)