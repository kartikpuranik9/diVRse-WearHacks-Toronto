scriptId = 'com.thalmic.keyboardmapper.mouseclickconnector'
minMyoConnectVersion = '0.12.0'
scriptTitle = 'mouse-click-connector'

function activeAppName()
    return 'mouse-click-connector'
end

----------------------------
-- Helpers
function conditionallySwapWave(pose)
    if myo.getArm() == 'left' then
        if pose == 'waveIn' then
            pose = 'waveOut'
        elseif pose == 'waveOut' then
            pose = 'waveIn'
        end
    end
    return pose
end

unlockType = ''
function unlock(type)
    unlockType = type
    myo.unlock(unlockType)
end

function getUnlockType()
    return unlockType
end

keyPressSuspendedUnlockTimer = false
function keyPress(key, edge, ...)

    if edge == 'down' and getUnlockType() == 'timed' then
        unlock('hold')
        keyPressSuspendedUnlockTimer = true
    end

    myo.notifyUserAction()
    myo.keyboard(key, edge, ...)

    if edge == 'up' and keyPressSuspendedUnlockTimer then
        unlock('timed')
        keyPressSuspendedUnlockTimer = false
    end
end

mouseClickSuspendedUnlockTimer = false
function mouseClick(button, edge, ...)
    if edge == 'down' and getUnlockType() == 'timed' then
        unlock('hold')
        mouseClickSuspendedUnlockTimer = true
    end

    myo.notifyUserAction()
    myo.mouse(button, edge, ...)

    if edge == 'up' and mouseClickSuspendedUnlockTimer then
        unlock('timed')
        mouseClickSuspendedUnlockTimer = false
    end
end

----------------------------
-- Map poses to functions
LOCKED_BINDINGS = {
    doubleTap_on = function() unlock('timed') end
}

UNLOCKED_BINDINGS = {
    fist_on = function() mouseClick('left', 'click') end
}

function currentBindings()
    if myo.isUnlocked() then
        return UNLOCKED_BINDINGS
    else
        return LOCKED_BINDINGS
    end
end

function onPoseEdge(pose, edge)
    pose = conditionallySwapWave(pose)
    fn = currentBindings()[pose .. '_' .. edge]
    if fn then
        fn()
    end
end

---------------------------
-- Script activation handling
function onForegroundWindowChange(app, title)
    return true
end

---------------------------
-- Set how the Myo Armband handles locking
myo.setLockingPolicy('none')

