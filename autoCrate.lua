
warn("BEGIN")  -- just here during testing

-- Declaration of paths to be used
local PlayerBin = game:GetService("Players")
local chr = PlayerBin.LocalPlayer.Character     -- for teleporting the player
local tCFR = chr.HumanoidRootPart.CFrame.p      -- for teleporting the player to their original place

-- Creating an instance to run the While Loop
if not PlayerBin.LocalPlayer:FindFirstChild("LOOP_CONSTRAINT") then
    
    g_ = Instance.new("Part")
    g_.Name = "LOOP_CONSTRAINT"
    g_.Parent = PlayerBin.LocalPlayer
    g_.Transparency = 1
    
    print("Loop constraint created successfully")
    
else
        
    PlayerBin.LocalPlayer:FindFirstChild("LOOP_CONSTRAINT").Transparency = 1    
    
end

-- inpt => wait time between crate search (while loop iteration)
-- iter => counts the iteration (for testing i guess)
local inpt = 90
local iter = 0
local total = 0

-- function to count the number of crates/boxes spawned in the workspace
local function count()
    
    val = 0
    
    for i,v in pairs(Game.Workspace:GetChildren()) do
        
        if v:FindFirstChild("TouchInterest") and v:FindFirstChild("Open") then
            
            val = val + 1
            
        end
    end
    
    return val
    
end

while wait(inpt) do
    
    tCFRi = chr.HumanoidRootPart.CFrame.p
    
    -- checks if the user has indicated they want to have the loop active
    if PlayerBin.LocalPlayer:FindFirstChild("LOOP_CONSTRAINT").Transparency == 1 then 
        
        -- counts and prints the iteration value and indicates the loop is active
        iter = iter + 1
        warn("Looping is Active")
        print("Iteration: ", iter)
        
        print(count(), "Objects")
        
        if count() > 0 then

            for i,v in pairs(Game.Workspace:GetChildren()) do
                
                -- checks if there are any crates/any other objects of interest spawned in the workspace
                if v:FindFirstChild("TouchInterest") and v:FindFirstChild("Open") then
                    
                    -- counts the total number of crates obtained ( not 100% precise because some crates may, rarely, not be picked up on their first, respective, iteration )
                    total = total + 1
                    
                    -- determines the location of the thing
                    cfPass = v.CFrame.p
                    -- print(cfPass)
                    
                    -- teleports the player to the object until the object has been picked up
                    chr:SetPrimaryPartCFrame(CFrame.new(cfPass.x, cfPass.y + 1, cfPass.z))
                    wait(0.25)
                    
                end
                
            end
        
            chr:SetPrimaryPartCFrame(CFrame.new(tCFRi.x, tCFRi.y + 1, tCFRi.z))
        
        end
    
    -- fires true when the user indicates they want to cease the looping ( or terminate the script )
    else
        
        if PlayerBin.LocalPlayer:FindFirstChild("LOOP_CONSTRAINT").Transparency == 0 and iter ~= 0 then
            
            -- resets the iteration value so this branch doesn't repeatedly fire true
            -- teleports the user to the location when they initiated the loop
            iter = 0
            chr:SetPrimaryPartCFrame(CFrame.new(tCFR.x, tCFR.y + 1, tCFR.z))
            
             warn("Loop ceased, waiting indefinitely until indication to restart looping...")
             print("Total crates thus far:", total)
        
        end    
        
        if PlayerBin.LocalPlayer:FindFirstChild("LOOP_CONSTRAINT").Transparency == 0.5 then 
            
            warn("LOOP TERMINATED")
            print("Total crates:", total)
            break end
        
    end
end

