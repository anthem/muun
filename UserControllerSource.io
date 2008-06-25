UserControllerSource := Object clone do (
	setUserSource := method(source,
		self source := source
		source objectEvent("")
	) 
)