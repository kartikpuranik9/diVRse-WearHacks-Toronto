scriptId = 'com.thalmic.mousetest'
scriptTitle = 'Mouse Controls'

myo.setLockingPolicy('none')

-- This allows a user to control their cursor using the Myo.
-- Gestures:

-- Fist: Click and drag

-- Helpers

-- Switches waveIn and waveOut for left arm to make wave gestures
-- waveLeft and waveRight for both arms.
function conditionallySwapWave(pose)
    if myo.getArm() == "left" then
        if pose == "waveIn" then
            pose = "waveOut"
        elseif pose == "waveOut" then
            pose = "waveIn"
        end
    end
    return pose
end

-- Handle gestures from Myo

function onPoseEdge(pose, edge)

    pose = conditionallySwapWave(pose)

    -- Unlock/Lock Mechanism
    if pose == "doubleTap" then
        if not myo.mouseControlEnabled() then -- Unlock
            if edge == "off" then
                myo.controlMouse(true)
                myo.centerMousePosition()
                myo.debug("ON")
            elseif edge == "on" then
                myo.vibrate("medium")
            end
        elseif myo.mouseControlEnabled() then -- Lock
            if edge == "off" then
                myo.controlMouse(false)
                myo.debug("OFF")
            elseif edge == "on" then
                myo.vibrate("medium")
            end
        end
    end

-- Checks threshold of chest compression
function checkChestCompression()
    xA,yA,zA = myo.getAccelWorld()
    myo.debug('***')
    myo.debug(xA)
    myo.debug(yA)
    myo.debug(zA) 
    if (0.1 > zA or zA > 0.1)) then
        
            myo.vibrate("medium")
            myo.debug("Exceeded threshold")
            
        end
    end

    -- Other poses only when active
    if myo.mouseControlEnabled() then

        -- Click and drag
        if pose == "fist" then
            if edge == "on" then -- clicks down to drag
                myo.notifyUserAction()
                myo.mouse("left","down")
                myo.debug("DRAG HOLD")

                checkChestCompression()

            elseif edge == "off" then -- release click
                myo.mouse("left","up")
                myo.debug("DRAG RELEASE")
            end
        end

    end

end

-- Other callbacks

function onPeriodic()
end

function onForegroundWindowChange(app, title)
    return true
end

function activeAppName()
    return "Mouse Controls"
end

function onActiveChange(isActive)
end
