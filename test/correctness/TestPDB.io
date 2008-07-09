Importer addSearchPath("../..")

PersistentObject := Object clone do (
	name ::= ""

	getName := method(
		self name
	)
)

PersistentObjectMap := Object clone do (
	setPersistenceManager := method(mgr,
		self persistenceManager := mgr
		self store := persistenceManager createOrGetStore("persistentLibrary")
		self
	)
	
	add := method(obj,
		store atPut(obj name, obj)
	)
	
	get := method(name,
		store at(name)
	)
)

manager := PDBPersistenceManager //clone 
manager registerSlots(PersistentObject, name)

manager setPath("test.tc")
manager open
if(manager hasStore("persistentLibrary"),
	map := PersistentObjectMap clone setPersistenceManager(manager)
	"Reusing store." println,

	map := PersistentObjectMap clone setPersistenceManager(manager)
	bob := PersistentObject clone setName("Bob")
	tom := PersistentObject clone setName("Tom")
	"Bob before adding: #{bob}" interpolate println
	map add(bob)
	"Bob after adding: #{map get(\"Bob\")}" interpolate println
	manager sync
	manager close
	manager open
)

manager repoen

"Bob after (re)opening: #{map get(\"Bob\")}" interpolate println
