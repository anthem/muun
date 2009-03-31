/*
An Authentication object is an object that implements a method of authenticating identities.
*/
Authentication := Object clone do (
	store ::= nil

	//doc authenticate() attempts to authorize an identity.
	//Returns nil if the identity's key is is not recognized,
	//false if the identity's key is recognized but the authentication token fails,
	//and true if the identity is authenticated.
	authenticate := method(ident,
		if(store hasKey(ident key)) then (
			return store hasAuthenticationIdentity(ident)
		) else ( 
			return nil
		)
	)

	//doc withIdentityStore creates a clone of this Authentication with its 
	//identityStore slot set to the specified object.
	withStore := method(store,
		self clone setStore(store)
	)
)