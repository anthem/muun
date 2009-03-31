PDBStore := PMap clone do (
	hasKey := method(key,
		at(key) != nil
	)
)