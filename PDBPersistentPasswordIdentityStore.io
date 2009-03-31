/*
Subclass of PDBPersistentPasswordIdentityStore for storing PasswordIdentity's
*/
PDBPersistentPasswordIdentityStore := PDBPersistentAuthenticationStore clone do (
	init := method(
		setStoreName("passwordIdentity")
		resend
	)
	
	registerSlots := method(ident,
		persistenceManager registerSlots(ident, username, encryptedPassword)
	)
)