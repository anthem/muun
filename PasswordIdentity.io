/*
PasswordIdentity is an AuthenticationIdentity with a name as the key and a
password as an authentication token.
*/
PasswordIdentity := AuthenticationIdentity clone do (
	username ::= ""
	encryptedPassword ::= MD5 clone appendSeq("") md5String

	withUsername := method(username,
		self clone setUsername(username)
	)
	
	withUsernameAndPassword := method(username, password,
		self clone setUsername(username) setPassword(password)
	)
	
	authenticatesAs := method(other,
		self username == other username and self encryptedPassword == other encryptedPassword
	)
	
	setPassword := method(unencrypted,
		setEncryptedPassword(MD5 clone appendSeq(unencrypted) md5String)
		self
	)

	key := method(
		username
	)
	
	setKey := getSlot("setUsername")
)