getgenv().prefix = ':' -- The prefix for the commands example: :drop 
getgenv().controller = 0 
getgenv().altFPS = 30 -- fps for alts
getgenv().alts = { -- max 38
   Alt1 = 0,

}


-- loader

loadstring(game:HttpGet("https://raw.githubusercontent.com/Officialtomdev/kobealtctrl/main/ctrl.lua", true))()