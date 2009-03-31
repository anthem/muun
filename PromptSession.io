PromptSession := TextSession clone do (
	startPrompt := method(
		while(prompts size > 0 and isOpen,
			if(line := channel readln) then (
				if(isOpen) then (
					prompts last respondTo(line)
				)
			) else (
				close
			)
		)
		if(isOpen,
			channel writeln("No more prompts. Closing session.")
			close
		)
	)
)