scriptId = 'com.thalmic.poseCheck'
scriptTitle = 'Pose Check'

myo.setLockingPolicy('none')


function onPoseEdge(pose, edge)  
    myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
end  

-- Other callbacks

function onPeriodic()
end

function onForegroundWindowChange(app, title)
    return true
end

function activeAppName()
    return "Orientation Controls"
end

function onActiveChange(isActive)
end