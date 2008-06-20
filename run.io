#!/usr/bin/env io

muun := MUUN clone

admin := UserIdentity withUsernameAndPassword("admin", "admin")
lib := UserLibrary clone learn(admin)
"Librray #{lib} has #{lib size} idents and protos #{lib protos}" interpolate println
auth := UserAuthentication clone setIdentityLibrary(lib)
server := MUUNTelnetServer clone setPort(2150)
userManager := UserManager clone setSource(server) setAuthentication(auth)

//muun setUserManager(userManager)

server start
