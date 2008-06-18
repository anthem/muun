#!/usr/bin/env io

muun := MUUN clone

admin := UserIdentity withUsernameAndPassword("admin", "admin")
auth := UserAuthentication clone learn(admin)
server := MUUNTelnetServer clone setPort(2150)
userManager := MUUNUserManager clone setSource(server) setAuthentication(auth)
server start
