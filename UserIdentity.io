UserIdentity := Object clone do (
	appendProto(Identity)

	username := "Unnamed"
	encryptedPassword := MD5 clone appendSeq("") md5String
	
	withUsername := method(username,
		UserIdentity clone setUsername(username)
	)
	
	withUsernameAndPassword := method(username, password,
		UserIdentity clone setUsername(username) setPassword(password)
	)
	
	authenticatesAs := method(other,
		self username == other username and self encryptedPassword == other encryptedPassword
	)
	
	setUsername := method(username,
		self username := username
		self
	)
	
	setPassword := method(unencrypted,
		self encryptedPassword := MD5 clone appendSeq(unencrypted) md5String
		self
	)
)