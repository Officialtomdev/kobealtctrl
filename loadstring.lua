getgenv().prefix = ':' -- The prefix for the commands example: :fly username
getgenv().controller = 0 -- Enter controllers userid! Make sure the id isnt in the alts
getgenv().altFPS = 30 -- set the FPS for alts
getgenv().alts = { -- Max 38 alts! (enter user ids where the 0 is)
   Alt1 = 0,

}


-- loader

loadstring(game:HttpGet("", true))()