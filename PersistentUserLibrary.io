/*
UserLibrary coordinates the connection, authentication and data access and management of a set of users
*/

PersistentUserLibrary := UserLibrary clone do (
	persistenceManager := nil

	setPersistenceManager := method(mgr,
		self persistenceManager := mgr
		store := PMap clone
		prependProto(store) // prepend the store so that all our mappings go into the PMap
		persistenceManager registerStore("userLibrary", store)
	)
)
