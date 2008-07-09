pm := PDBPersistenceManager clone setPath("test.tc") open
pul := PersistentUserLibrary clone do (
	setPersistenceManager(pm)
	learn(UserIdentity withUsernameAndPassword("admin", "admin"))
)

pul hasIdentity(UserIdentity withUsernameAndPassword("admin", "admin")) println