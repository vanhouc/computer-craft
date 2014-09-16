args = {...}
local programName = args[1]
local pasteIndex = "8jdAR5pT"
 
shell.run("rm "..programName)
site = http.get("https://raw.githubusercontent.com/vanhouc/computer-craft/master/" .. programName .. ".lua")
if (site) then
    file = fs.open(programName, "w")
    if (file) then
        file.write(site.readAll())
        file.close()
        print("Successfully updated " .. programName)
    end
else
    print("failed to load site")
end