UserManager := Object clone do (
	users ::= nil
	
	init := method(
		setUsers(Map clone)
	)

	addUser := method(user,
		users atPut(user identity key, user)
		//user session pushPrompt(MainUserPrompt withUser(user))
	)
)