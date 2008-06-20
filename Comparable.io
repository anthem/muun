Comparable := Object clone do (
	== := method(other,
		if(self hasSlot("compare"), self compare(other) == 0, resend)
	)
	
	!= := method(other,
		if(self hasSlot("compare"), self compare(other) != 0, resend)
	)

	< := method(other,
		if(self hasSlot("compare"), self compare(other) == -1, resend)
	)

	> := method(other,
		if(self hasSlot("compare"), self compare(other) == 1, resend)
	)

	<= := method(other,
		if(self hasSlot("compare"), self compare(other) != 1, resend)
	)

	>= := method(other,
		if(self hasSlot("compare"), self compare(other) != -1, resend)
	)
)