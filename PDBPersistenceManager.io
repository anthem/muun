PDBPersistenceManager := PersistenceManager clone do (
	withPath := method(path,
		PDB setPath(path) open
		self
	)
	
	list("open", "close", "show") foreach(x, setSlot(x, method(PDB doMessage(x asMessage))))

	sync := method(
		PDB sync
		PDB collectGarbage
	)

	getOrCreateStore := method(name,
		if(hasStore(name), getStore(name), newStore(name))
	)
	
	setStore := method(name, store,
		PDB root atPut(name, store)
	)
	
	newStore := method(name,
		store := PMap clone
		PDB root atPut(name, store)
		store
	)
	
	hasStore := method(name,
		getStore(name) != nil
	)
	
	getStore := method(name,
		PDB root at(name)
	)
	
	registerSlots := method(object,
		object doMessage(Message clone setName("pSlots") setArguments(call message arguments slice(1)))
	)
)