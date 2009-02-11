/*
UserLibrary coordinates the connection, authentication and data access and management of a set of users
*/

PersistentUserLibrary := Library clone do (
	storeName := "userLibrary"
	persistenceManager := nil
	
	init := method(
		self store := PMap clone
	)
	
	learn := method(ident,
		persistenceManager registerSlots(ident, username, encryptedPassword)
		super(learn(ident))
		persistenceManager sync
		self
	)

	unlearn := method(ident,
		resend
		persistenceManager sync
		self
	)
	
	hasKey := method(key,
		self store at(key)
		self store hasSlot(key)
	)

	setPersistenceManager := method(mgr,
		self persistenceManager := mgr
		self store = persistenceManager getOrCreateStore(storeName, store)
		self
	)
)
