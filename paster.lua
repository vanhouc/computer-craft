args = {...}
local programName = args[1]
local pasteIndex = "8jdAR5pT"
 
shell.run("rm "..programName)
shell.run("pastebin get "..pasteIndex.." "..programName)
print("Success! " .. programName .. " has been updated")