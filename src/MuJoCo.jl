module MuJoCo

using PythonCall

const dm_control = PythonCall.pynew()
const mujoco = PythonCall.pynew()

function __init__()
    PythonCall.pycopy!(dm_control, pyimport("dm_control"))
    PythonCall.pycopy!(mujoco, pyimport("dm_control.mujoco"))
end

export dm_control,
       mujoco


end
