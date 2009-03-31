/*
Prompt is an abstract interface for a prompt. That is, a proto that
returns a string that prompts the user for some data, and methods to respond
to that data meaningfully.

promptString : returns a string meaningful to the user to signify that data
	should be entered.
respondTo(string) : handle a line of input from the user.
showPrompt : display the prompt; by default writes promptString
setSession : sets the session for which the prompt is started
activate : called when prompt is (re)activated
deactivate : called when prompt is deactivated
*/

Prompt := Object clone do (
	session ::= nil
	promptString := ""
	
	respondTo := method(line,
		self
	)
	
	activate := method(
		showPrompt
	)
	
	deactivate := method(
		nil
	)
	
	showPrompt := method(
		session channel write(promptString)
	)
)