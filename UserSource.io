UserSource := Object clone do (
	handleUser := method(user, source,
		Exception raise("Abstract method called")
	)
)