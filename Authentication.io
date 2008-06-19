/*
An Authentication object holds a database of known identities and serves
requests for the status of an identity given information about a specific identity.
*/
Authentication := Object clone do (
	//doc learn(identity) records the identity as a known identity
	learn := method(identity,
		return self
	)
	
	unlearn := method(identity,
		return self
	)
	
	//doc challenge(channel) communicates via channel to obtain information about
	//an identity to be authenticated, and returns the result of that authentication
	// (see authenticate()).
	challenge := method(channel,
		return authenticate(nil)
	)

	//doc authenticate() attempts to authorize an identity uniquely identified
	//by the data passed as arguments. Returns nil if the identity is not recognized,
	//false if the identity is recognized but the information (such as a password)
	//is inconsistent or incorrect, and true if the identity can be authenticated.
	//
	//Upon each of these results, callback blocks are invoked. Override these:
	//Identity not recognized: handle
	authenticate := method(token,
		return nil
	)
)