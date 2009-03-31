/*
PersistenceAuthenticationStore is an AuthenticationStore that provides an
interface for persisting authentication stores using a PDBPersistenceManager.

This proto must be subclassed to override registerSlots.
*/
PDBPersistentAuthenticationStore := AuthenticationStore clone do (
	storeName ::= ""
	persistenceManager := nil
	
	init := method(
		resend
		setStore(PDBStore clone) # set the AuthStore's store map
	)
	
	withPersistenceManager := method(pm,
		self clone setPersistenceManager(pm)
	)
	
	setPersistenceManager := method(mgr,
		self persistenceManager := mgr
		store = persistenceManager getOrCreateStore(storeName)
		self
	)
	
	insert := method(ident,
		registerSlots(ident)
		resend
		persistenceManager sync
		self
	)
	
	remove := method(ident,
		resend
		persistenceManager sync
		self
	)
	
	registerSlots := method(ident,
		persistenceManager registerSlots(ident)
	)
)
