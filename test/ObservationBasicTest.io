Importer addSearchPath(Path with(System launchPath, "..", ".."))

Observed := Object clone do (
	appendProto(Observable)

	init := method(
		addObservation(normalEvent, eventWithArgs, neverFiredEvent)
	)
	
	fireNormalEvent := method(
		normalEvent notifyObservers
	)

	fireEventWithArgs := method(args,
		eventWithArgs notifyObservers(args)
	)
	
	fireNeverFiredEvent := method(
		neverFiredEvent notifyObservers
	)
)

BasicTest := UnitTest clone do (
	setUp := method(
		self observed := Observed clone
		self fireCount := 0
	)
	
	eventHappened := method(
		fireCount = fireCount + 1
	)
	
	eventHappenedWithArgs := method(arg,
		fireCount = fireCount + arg
	)
	
	neverFiredEventHappened := method(
		fail
	)
	
	testNormalEvent := method(
		observed observationNamed("normalEvent") appendObserver(block(eventHappened))
		observed fireNormalEvent
		assertEquals(fireCount, 1)
	)
	
	testEventWithArgs := method(
		observed eventWithArgs prependObserver(block(x, eventHappenedWithArgs(x)))
		observed fireEventWithArgs(5)
		assertEquals(fireCount, 5)
	)
	
	testNeverFiredEvent := method(
		observed neverFiredEvent appendObserver(block(neverFiredEventHappened))
		observed neverFiredEvent clearObservers
		observed fireNeverFiredEvent
		assertEquals(fireCount, 0)
	)
)
