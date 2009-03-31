/*
AuthenticationIdentity is an interface for an implementation of an
identity which is authenticated by an Authentication object.

An AuthenticationIdentity must provide a 'key' object that uniquely identifies it within its Authentication
*/
AuthenticationIdentity := Object clone do (	
	key ::= ""

	//doc authenticatesAs returns true or false depending on whether the two
	// identification tokens are equal for purposes of authentication.
	authenticatesAs := method(other,
		return false
	)
)