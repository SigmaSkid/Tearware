## api v2 servercall:
The server has no clue who is calling it.  
Refer to the example from the official documentation.  
https://teardowngame.com/modding/api.html#ServerCall  
The client provides their own ID as a parameter in ServerCall.  
It's.. insecure and stupid by design.  
It could be fixed by issuing our own secret unique ids.  
But that's also a major hassle and performance waste for singleplayer.  
Honestly, it's probably.. fine? I mean, it could be hilarious,  
to spoof client id on clientside and mess with people.  
But this 'security' vulnerability likely won't affect anyone.  