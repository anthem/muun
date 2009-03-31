/*
A session is a transient representation of and a way to manage communication
between a remote user and the system.

Sessions can be closed and have a 'channel' for communication.
*/
Session := Object clone do (
	appendProto(Observable)
	channel ::= nil
	
	init := method(
		addObservation(beforeCloseEvent, closeEvent)
	)
	
	close := method(
		beforeCloseEvent notifyObservers(self)
		channel close
		closeEvent notifyObservers(self)
	)
	
	isOpen := method(
		return channel isOpen
	)
)