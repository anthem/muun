Importer addSearchPath(Path with(System launchPath, "..", "Authentication"))

AuthenticationTest := UnitTest clone do (
	setUp := method(
	)
	
	tearDown := method(
	)
	
	testAuthenticationIdentity := method(
		bob := NameIdentity withName("Bob")
		tom := NameIdentity withName("Tom")

		assertFalse(bob authenticatesAs(tom))
		assertTrue(bob authenticatesAs(bob))
		assertEquals(bob key, "Bob")
		assertTrue(tom authenticatesAs(NameIdentity clone setName("Tom")))
	)
	
	testPasswordAuthenticationIdentity := method(
		mary := PasswordIdentity withUsernameAndPassword("Mary", "password")
		mary2 := PasswordIdentity withUsernameAndPassword("Mary", "password")
		jane := PasswordIdentity withUsernameAndPassword("Jane", "pass")
		marynopass := PasswordIdentity withUsername("Mary")
		
		assertTrue(mary authenticatesAs(mary2))
		assertTrue(mary2 authenticatesAs(mary))
		assertFalse(mary authenticatesAs(PasswordIdentity withUsernameAndPassword("Mary", "passworde")))
		assertFalse(mary authenticatesAs(jane))
		assertFalse(mary authenticatesAs(marynopass))
	)
	
	testAuthenticationStore := method(
	 	bob := PasswordIdentity withUsernameAndPassword("Bob", "password")
		tom := PasswordIdentity withUsernameAndPassword("Tom", "password")
		joe := PasswordIdentity withUsername("Joe")
		bobnopass := PasswordIdentity withUsername("Bob")

		store := AuthenticationStore clone
		store insert(bob)
		store insert(tom)
	
		assertTrue(store hasKey("Bob"))
		assertTrue(store hasKey("Tom"))
		assertFalse(store hasKey("Joe"))
		assertFalse(store hasKey("Mary"))
		assertTrue(store hasAuthenticationIdentity(bob))
		assertFalse(store hasAuthenticationIdentity(joe))
		assertFalse(store hasAuthenticationIdentity(bobnopass))
		store remove("Bob")
		assertFalse(store hasAuthenticationIdentity(bob))
	)
	
	testAuthentication := method(
		store := AuthenticationStore clone
		store insert(PasswordIdentity withUsernameAndPassword("Bob", "test1"))
		store insert(PasswordIdentity withUsernameAndPassword("Tom", ""))
		store insert(PasswordIdentity withUsernameAndPassword("Bill", "1234-0985892f34"))
		bobnopass := PasswordIdentity withUsernameAndPassword("Bob", "")
		tomwithpass := PasswordIdentity withUsernameAndPassword("Tom", "batty")
		bill := PasswordIdentity withUsernameAndPassword("Bill", "1234-0985892f34")
		jane := PasswordIdentity withUsernameAndPassword("Jane", "8675309")
		auth := Authentication withStore(store)
		
		assertFalse(auth authenticate(bobnopass))
		assertFalse(auth authenticate(tomwithpass))
		assertTrue(auth authenticate(bill))
		assertNil(auth authenticate(jane))
	)
	
	testAuthenticationManager := method(
		pwBob := PasswordIdentity withUsernameAndPassword("Bob", "loblaw")
		pwTom := PasswordIdentity withUsernameAndPassword("Tom", "pompom")
		pwJoe := PasswordIdentity withUsernameAndPassword("Joe", "dodo")
		pwLarry := PasswordIdentity withUsernameAndPassword("Larry", "")
		nameBob := NameIdentity withName("Bob")
		nameJane := NameIdentity withName("Jane")
		nameMary := NameIdentity withName("Mary")
		nameLarry := NameIdentity withName("Larry")
		pwStore := AuthenticationStore clone
		nameStore := AuthenticationStore clone
		pwStore insert(pwBob)
		pwStore insert(pwTom)
		pwStore insert(pwJoe)
		nameStore insert(nameBob)
		nameStore insert(nameJane)
		nameStore insert(nameMary)
		pwAuth := Authentication withStore(pwStore)
		nameAuth := Authentication withStore(nameStore)
		authmgr := AuthenticationManager clone setExceptOnDuplicateKey(false) appendAuthentication(pwAuth) appendAuthentication(nameAuth)
		
		assertTrue(authmgr hasKey("Bob"))
		assertTrue(authmgr hasKey("Tom"))
		assertTrue(authmgr hasKey("Joe"))
		assertTrue(authmgr hasKey("Mary"))
		assertTrue(authmgr hasKey("Jane"))
		assertFalse(authmgr hasKey("Larry"))
		
		assertNil(authmgr authenticationForIdentity(pwLarry))
		assertNil(authmgr authenticationForIdentity(nameLarry))
		assertEquals(pwAuth, authmgr authenticationForIdentity(pwTom))
		assertEquals(pwAuth, authmgr authenticationForIdentity(pwJoe))
		assertEquals(nameAuth, authmgr authenticationForIdentity(nameMary))
		assertEquals(nameAuth, authmgr authenticationForIdentity(nameJane))
		assertEquals(pwAuth, authmgr authenticationForIdentity(pwBob))
		assertEquals(nameAuth, authmgr authenticationForIdentity(nameBob))
		
		assertTrue(authmgr authenticate(pwBob))
		assertTrue(authmgr authenticate(nameBob))
		assertTrue(authmgr authenticate(pwTom))
		assertNil(authmgr authenticate(pwLarry))
		assertTrue(authmgr authenticate(nameMary))
		assertTrue(authmgr authenticate(nameJane))
		assertNil(authmgr authenticate(pwLarry))
		assertNil(authmgr authenticate(nameLarry))
		
		authmgr removeAuthentication(nameAuth)

		assertTrue(authmgr authenticate(pwBob))
		assertNil(authmgr authenticate(nameBob))
		assertTrue(authmgr authenticate(pwTom))
		assertNil(authmgr authenticate(pwLarry))
		assertNil(authmgr authenticate(nameMary))
		assertNil(authmgr authenticate(nameJane))
		assertNil(authmgr authenticate(pwLarry))
		assertNil(authmgr authenticate(nameLarry))
	)
)