/*
UserShellPrompt is the prompt that serves as a "lowest-level" method of
handling user input in the event that a) other prompts fail to handle the input
b) no other prompts exist.
*/

UserShellPrompt := Prompt clone do(
	promptString := ""
	
	activate := method(
		mainMenu
		resend
	)

	
	mainMenu := method(
		self promptString := """Main menu:
1) Change character
2) Change user information
3) Quit
Please make your selection: """
		self respondTo := method(input,
			response := input asNumber
			if(response isNan or response > 3 or response < 1) then (
				session channel writeln("\n\nPlease enter a number between 1 and 3.")
				showPrompt
			) else (
				if(response == 1) then (
					notYetImplemented("Change default character")
					showPrompt
				) elseif (response == 2) then (
					notYetImplemented("Change user information")
					showPrompt
				) elseif (response == 3) then (
					session channel writeln("See you next time.")
					session close
				)
			)
		)
	)
	
	respondTo := method(input,
		if(input == "quitnow",
			session do (
				channel writeln("Goodbye.")
				close
			)
		)
	)

	notYetImplemented := method(feature,
		session channel writeln("Sorry, '#{feature}' is not yet implemented!" interpolate)
		writeln("Sorry, '#{feature}' is not yet implemented!")
	)	
)