Importer addSearchPath(Path with(System launchPath, "..", "Persistence"))
Importer addSearchPath(Path with(System launchPath, "..", "Authentication"))

PersistenceTest := UnitTest clone do (
	testPDBPersistenceManager := method(
	)
	
	testPDBPersistentPasswordIdentityStore := method(
		testtc := File with("test.tc")
		testtc remove
		assertFalse(testtc exists)

		pm := PDBPersistenceManager withPath("test.tc")
		store := PDBPersistentPasswordIdentityStore withPersistenceManager(pm)
		assertEquals(store storeName, "passwordIdentity")
		assertEquals(store persistenceManager, pm)

		bob := PasswordIdentity withUsernameAndPassword("Bob", "password")
		bobnopass := PasswordIdentity withUsernameAndPassword("Bob", "")
		tom := PasswordIdentity withUsernameAndPassword("Tom", "password")

		store insert(bob)
		assertTrue(testtc exists)
		assertTrue(store hasKey("Bob"))
		
		auth := Authentication withStore(store)
		assertEquals(auth store, store)
		assertTrue(auth store hasKey("Bob"))
		assertTrue(auth store hasAuthenticationIdentity(bob))
		assertFalse(auth store hasAuthenticationIdentity(bobnopass))
		assertFalse(auth store hasAuthenticationIdentity(tom))
		
		store insert(tom)
		assertTrue(auth authenticate(tom))
		
		store remove(tom)
		assertNil(auth authenticate(tom))
		
		pm close
		pm2 := PDBPersistenceManager withPath("test.tc")
		store2 := PDBPersistentPasswordIdentityStore withPersistenceManager(pm2)
		auth setStore(store2)
		assertEquals(auth store, store2)
		assertTrue(auth authenticate(bob))
		assertFalse(auth authenticate(bobnopass))
		assertNil(auth authenticate(tom))
		
		testtc remove
		assertFalse(testtc exists)
	)
)