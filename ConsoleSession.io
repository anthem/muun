/*
ConsoleSession provides abstractions for handling a user at the local terminal.
*/
ConsoleSession := Object clone do (
	readln := method(
		ReadLine readLine
	)
	
	close := method(
		// do nothing
	)
)