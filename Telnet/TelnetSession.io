/*
A TelnetSession provides mechanisms for interacting with a remote Telnet user
via socket.
The Telnet terminal protocol is not supported (yet), just line- and text-based
interaction.

TelnetSession is a TextSession.
*/

TelnetSession := TextSession clone do (
	setChannel := method(ch,
		self channel := ch
		ch do (
			setSlot("writeln", method(data,
				self write(data .. "\r\n")
			))

			setSlot("readln", method(
				line := readUntilSeq("\n")
				while(line isError,
					line := readUntilSeq("\n")
				)
				line asMutable strip
			))
		)
		self
	)
	
	isOpen := method(
		self open := channel isOpen
	)
)