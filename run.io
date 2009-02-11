#!/usr/bin/env io

Importer addSearchPath(Path with(System launchPath, "World"))

config := Map clone do (
	atPut("persistenceFile", Path with(System launchPath, "muun.tc"))
	atPut("telnetPort", 2150)
	atPut("textBanner", "This is the banner. Read me.")
)

muun := MUUN clone

// set up the persistence manager that will handle the creation, sync and teardown
// of persistence data stores
pm := PDBPersistenceManager withPath(config at("persistenceFile"))

server := MUUNTelnetServer clone do (
	setPort(config at("telnetPort"))
)

// set up the userManager that will serve users to the controller manager
userManager := UserManager clone do (
	// we need a user source.. which is the telnet server created above
	setSource(server)
	
	// and we need a way to authenticate those users ...
	setAuthentication(UserAuthentication clone do (
		// set the introductory text banner we show the user before/during authentication
		setBanner(config at("textBanner"))

		// the authenticator needs to know who and how to authenticate,
		// so use a persistent library of user identities
		setIdentityLibrary(PersistentUserLibrary clone do (
			setPersistenceManager(pm)
			
			// set up an initial user (TEMPORARY)
			learn(UserIdentity withUsernameAndPassword("admin", "admin"))
		))
	))
)

// set up the World and its ControllerManager and EntityManager
worldControllerManager := WorldControllerLibrary clone do (
	setPersistenceManager(pm)
)

worldEntityManager := WorldEntityLibrary clone do (
	setPersistenceManager(pm)
)

world := World clone do (
	setControllerLibrary(worldControllerManager)
	setEntityLibrary(worldEntityManager)
)

// UserControllerManager is the final glue that binds the Server->User->Controller
// side to the World->Controller side, so this object both receives and serves directly.
// thus its behavior is defined at the top level, here.
userManager objectEvent("userJoined") appendListener(block(user,
	controller := UserController withUser(user)
	worldControllerManager learn(controller)
))


// fixme: put this elsewhere and don't block. instead make MUUN run block
server start

// sync and close the persistence file to save our data
pm do (
	sync
	close
)
