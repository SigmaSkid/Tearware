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