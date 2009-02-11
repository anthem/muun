/*
IdentityLibrary maintains a Library that stores Identities. 
*/

IdentityLibrary := Library clone do (
	//doc hasIdentity returns true or false indicating whether the given identity is stored in the Library.
	//doc if identity's username exist but the passwords do not match, false is returned
	hasIdentity := method(identity,
		hasKey(identity key) and at(identity key) authenticatesAs(identity)
	)
)