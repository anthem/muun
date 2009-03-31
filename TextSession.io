/*
TextSession extends a more basic session with a prompt shell (a standard method
of reading and dispatching input) and a 'closeEvent' to notify observers of
the session being closed.

Events:
closeEvent(session)
*/

TextSession := Session clone do(
	prompts := List clone

	init := method(
		self prompts := List clone
	)
	
	pushPrompt := method(prompt,
		prompts last ifNonNil(prompts last deactivate)
		prompts push(prompt)
		prompts last activate
	)
	
	popPrompt := method(
		prompts last ifNonNil(prompts last deactivate)
		oldprompt := prompts pop
		prompts last ifNonNil(prompts last activate)
		return oldprompt
	)
	
	enterPromptShell := method(
		pushPrompt(PromptShell withSession(self))
		while(isOpen,
			line := readln
			if(line != nil) then (
				prompts last respondTo(line)
			) else (
				close
			)
		)
	)
)