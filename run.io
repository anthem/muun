Importer addSearchPath(Path with(System launchPath, "Telnet"))
Importer addSearchPath(Path with(System launchPath, "Session"))
Importer addSearchPath(Path with(System launchPath, "Authentication"))
Importer addSearchPath(Path with(System launchPath, "Persistence"))


// initialize persistence engine using PDB, and set up the persistent password
// store and its authentication and challenge mechanisms

pm := PDBPersistenceManager withPath("muun.tc")
passwordStore := PDBPersistentPasswordIdentityStore withPersistenceManager(pm)
passwordAuthentication := Authentication clone setStore(passwordStore)
passwordChallenge := TextPasswordChallenge clone setAuthentication(passwordAuthentication)

// set up user management
userMgr := UserManager clone

onChallengeAccepted := block(session, identity,
	userMgr addUser(User withSessionAndIdentity(session, identity))
)

// Set up the prompt session manager for text-based session sources.
sessMgr := PromptSessionManager clone do (
	setChallenge(passwordChallenge)
	setShellPrompt(UserShellPrompt)
	setBanner("Welcome.")
)

// set up the telnet server as a source of sessions
server := TelnetServer clone setPort(2150) setSessionManager(sessMgr)

// set up local console session
//consoleMgr := ConsoleSessionManager clone setChallenge(passwordChallenge)
//consoleMgr challengeAccepted appendObserver(onChallengeAccepted)

// start accepting sessions
//consoleMgr @@start
server start

// no longer accepting sessions. we're done. save persistence data
pm sync
pm close