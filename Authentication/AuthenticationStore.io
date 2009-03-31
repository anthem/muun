/*
AuthenticationStore is a Library that maintain a collection of AuthenticationIdentities
*/

AuthenticationStore := Library clone do (
	//doc hasIdentity returns true or false indicating whether the given identity is stored in the Library.
	//doc if identity's username exists but the passwords do not match, false is returned.
	//doc This is stronger than the hasKey of the parent Library by taking into account the authentication.
	hasAuthenticationIdentity := method(identity,
		if(identity == nil or identity key size == 0, return false)
		hasKey(identity key) and at(identity key) authenticatesAs(identity)
	)
)