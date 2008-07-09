Identity := Object clone do (
	key ::= ""
	
	authenticatesAs := method(other,
		key == other key
	)	
)