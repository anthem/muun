UUIDIdentity := Object clone do (
	nullUUID := "00000000-0000-0000-0000-000000000000"
	uuid := nullUUID
	
	init := method(
		self uuid := UUID uuidRandom
	)

	withUUID := method(uuid,
		id := Identity clone
		id uuid := uuid
		return id
	)
	
	compare := method(other,
		return self uuid compare(other uuid)
	)
	
	setSlot("==", method(other,
		return compare(other) == 0
	))
)