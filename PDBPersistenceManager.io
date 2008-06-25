PDBPersistenceManager := PDB clone appendProto(PersistenceManager) do (
	registerStore := method(name, store,
		self root atPut(name, store)
	)
)