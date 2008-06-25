#!/usr/bin/env io

config := Map clone do (
	atPut("persistenceFile", "muun.tc")
	atPut("telnetPort", 2150)
	atPut("textBanner", "This is the banner. Read me.")
)

muun := MUUN clone

// set up the persistence manager that will handle the creation, sync and teardown
// of persistence data stores
pm := PDBPersistenceManager clone do (
	// set the path to the persistence file
	setPath(config at("persistenceFile"))
	
	// and open the database to ready it for use
	open
)

server := MUUNTelnetServer clone do (
	setPort(config at("telnetPort"))
)

// set up the userManager that will serve users to the controller manager
userManager := UserManager clone do (
	// we need a user source.. which is the telnet server created above
	setSource(server)
	
	// and we need a way to authenticate those users ...
	setAuthentication(UserAuthentication clone do (
		// the authenticator needs to know who and how to authenticate,
		// so use a persistent library of user identities
		setIdentityLibrary(PersistentUserLibrary clone do (
			setPersistenceManager(pm)
			
			// set up an initial user (TEMPORARY)
			learn(UserIdentity withUsernameAndPassword("admin", "admin"))
		))
	))
	
	// set the introductory text banner we show the user before/during login
	setBanner(config at("textBanner"))
)

/* controller stuff. design incomplete.
userControllerSource := UserControllerSource clone
userControllerSource setUserSource(userManager)
controllerManager := ControllerManager clone addControllerSource(userControllerSource)
*/ 

// fixme: put this elsewhere and don't block. instead make MUUN run block
server start

// sync and close the persistence file to save our data
pm do (
	sync
	close
)
