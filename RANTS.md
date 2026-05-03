## api v2 servercall:
The server has no clue who is calling it.  
Refer to the example from the official documentation.  
https://teardowngame.com/modding/api.html#ServerCall  
The client provides their own ID as a parameter in ServerCall.  
It's.. insecure and stupid by design.  
I mean, it could be hilarious,  
to spoof id on clientside and mess with people.  

## Issue 5 
Teardown issue tracker, issue #5 was marked as  
"won't fix" and it's fixed now.  
So, globals are now safe between quickloads.  
"I don't think the original bug report here is an issue, but rather an issue with how the script was implemented."  
So, all of the design decisions I made,  
because of this, are now incorrect :D  
Also features that were coded with the expectation  
that the globals can be randomly destroyed,  
might potentially leak memory on quick load instead.

## SetBodyTransform - not documented properly, different behavior client & server
It resets the velocity on local/host.  
But bodies keep their velocity on clients.  

## Inactive bodies not being networked.
Despite changing position of objects through `SetBodyTransform`,  
they are not being sent to the clients.  

## String find no longer uses '.' as any symbol unlike it did before.
This completely breaks my registry explorer search,  
because the '.' is also not being searched correctly.  
So I can't search for subkeys of specific keys anymore.  
Until I fix it.  

## Applying velocity is buggy in multiplayer.
Features that use SetPlayerVelocity(velocity),  
are almost completely broken in multiplayer.  
We need to figure out replacement strategy,  
or lock some features in multiplayer.  
But that defeats the point of porting it to multiplayer

## SetBodyActive False not networked.
It's just not. We need to call it on client ourselves.  
We can't just clientcall, because the API needs to be called inside of update.  
So we need a listener, a buffer, and to constantly check the stupid buffer.   

## Player Parameters being inconsistent.
walkingSpeed and jumpSpeed are the only player parameters applied per frame.  
"This value is applied for 1 frame!" - [docs](https://teardowngame.com/modding/api.html#SetPlayerParam)  
Also, why is jump speed and jump height connect to this one value.  
"The player's jump speed. The height of the jump depends non-linearly on the jump speed. This value is applied for 1 frame!"   
Jump height SHOULD be a separate variable, why is the speed connected to height.  

## GetCameraTransform is client only.
Server has to guess where the clients are looking,  
or clients have to network that data themeslves :D  
Even though server should probably already have this data.  