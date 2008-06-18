ObjectEvent := Object clone do (
	init := method(
		self listeners := List clone
	)

	withName := method(name,
		return ObjectEvent clone setName(name)
	)

	setName := method(name,
		self name := name
		self
	)
	
	appendListener := method(blk,
		self listeners append(blk)
		self
	)
	
	removeListener := method(blk,
		self listeners remove(blk)
		self
	)
	
	emptyListeners := method(
		self listeners empty()
		self
	)
	
	announce := method(
		self listeners foreach(blk, blk performWithArgList("call", call message argsEvaluatedIn(call sender)))
	)
)
