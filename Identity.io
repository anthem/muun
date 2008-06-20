Identity := Object clone do (
	init := method(
		key := ""
	)
	
	authenticatesAs := method(other,
		self key == other key
	)	
)