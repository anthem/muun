PersistenceManager := Object clone do (
	open := method(
		nil
	)
	
	sync := method(
		nil
	)
	
	close := method(
		nil
	)
	
	store := method(name,
		nil
	)
	
	getOrCreateStore := method(name,
		nil
	)
	
	newStore := method(name,
		nil
	)
	
	hasStore := method(name,
		false
	)
	
	getStore := method(name,
		nil
	)

	registerSlots := method(object,
		nil
	)
)