#!/usr/bin/env io

muun := MUUN clone

admin := UserIdentity withUsernameAndPassword("admin", "admin")
auth := UserAuthentication clone learn(admin)
server := MUUNTelnetServer clone setPort(2150)
userManager := UserManager clone setSource(server) setAuthentication(auth)

//muun setUserManager(userManager)

server start
