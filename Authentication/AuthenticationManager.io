/*
AuthenticationManager combines multiple Authentications so that multiple authentications
and/or stores can be handled together.

Note: This is functional but not necessarily practical. It only allows authentication
from one of many authentications, but does not allow management of identities.
Identity management must still be done directly in the stores. It is also possible
that new Identities could be devised that would incorrectly authenticate against others
that AuthenticationManager cannot differentiate, and thus falsely accept authentication
via the wrong method.

TODO: It is possible to set exceptOnDuplicateKey while duplicate keys exist.
*/
AuthenticationManager := Object clone do (
	authentications ::= List clone
	//doc if true, adding an authentication that introduces a duplicate key will raise an exception
	exceptOnDuplicateKey ::= true
	

	DuplicateKeyException := Exception clone
	
	checkForDuplicateKeys := method(auth,
		auth store store foreach(key, value,
			if(hasKey(key)) then (
				DuplicateKeyException raise("Authentication added, introducing duplicate key '#{key}'." interpolate)
			)
		)
	)
	
	//doc prepends the authentication to the authentications list. If it would
	//introduce a duplicate identity key, will raise DuplicateKeyExceptiom
	//if exceptOnDuplicateKeys is true.
	prependAuthentication := method(auth,
		if(exceptOnDuplicateKey, checkForDuplicateKeys(auth))
		authentications prepend(auth)
		self
	)
	
	//doc appends the authentication to the authentications list. If it would
	//introduce a duplicate identity key, will raise DuplicateKeyExceptiom
	//if exceptOnDuplicateKeys is true.
	appendAuthentication := method(auth,
		if(exceptOnDuplicateKey, checkForDuplicateKeys(auth))
		authentications append(auth)
		self
	)
	
	removeAuthentication := method(auth,
		authentications remove(auth)
		self
	)
	
	//doc removes the "best match" authentication object for the given identity,
	//or nil if none found. The identity must exist and be authenticatable in
	//one or more authentications in order to return a non-nil result.
	authenticationForIdentity := method(ident,
		auths := authentications select(a, a store hasKey(ident key))
		if(auths size == 0) then (
			return nil
		) else (
			return auths detect(a,
				authenticates := false
				try(authenticates := a authenticate(ident))
				authenticates
			) 
		)
	)

	//doc returns whether the key belongs to any identities among any authentications 
	hasKey := method(key,
		auths := authentications select(a, a store hasKey(key))
		return auths size > 0
	)
	
	//doc authenticates the identity using the "best match" authentication found
	//for this identity. See authenticationForIdentity.
	authenticate := method(ident,
		auth := authenticationForIdentity(ident)
		auth ifNonNilEval(auth authenticate(ident))
	)
)