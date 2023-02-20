module MuJoCo

using PythonCall

const dm_control = PythonCall.pynew()
const mujoco = PythonCall.pynew()
const mujoco_viewer = PythonCall.pynew()
const numpy  = PythonCall.pynew()

function __init__()
    PythonCall.pycopy!(dm_control, pyimport("dm_control"))
    PythonCall.pycopy!(mujoco, pyimport("dm_control.mujoco"))
    PythonCall.pycopy!(mujoco_viewer, pyimport("mujoco_viewer"))
    PythonCall.pycopy!(numpy, pyimport("numpy"))
end

export dm_control,
       mujoco,
       mujoco_viewer,
       numpy


end
