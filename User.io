User := Object clone do (
	identity ::= nil
	session ::= nil
	prompts ::= nil
	
	init := method(
		setPrompts(list())
	)
	
	withSessionAndIdentity := method(session, identity,
		self clone setSession(session) setIdentity(identity)
	)
	
	pushPrompt := method(prompt,
		prompt setUser(self)
		prompts last ifNonNil(prompts last deactivate)
		prompts push(prompt)
		prompts last activate
	)
	
	popPrompt := method(prompt,
		prompts last deactivate
		prompts last ifNonNil(prompts last activate)
		prompts pop setUser(nil)
	)
)