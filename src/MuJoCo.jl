module MuJoCo

using PythonCall

const dm_control = PythonCall.pynew()
const mujoco = PythonCall.pynew()
const mujoco_viewer = PythonCall.pynew()

function __init__()
    PythonCall.pycopy!(dm_control, pyimport("dm_control"))
    PythonCall.pycopy!(mujoco, pyimport("dm_control.mujoco"))
    PythonCall.pycopy!(mujoco_viewer, pyimport("mujoco_viewer"))
end

export dm_control,
       mujoco,
       mujoco_viewer


end
