using MuJoCo 
# using MuJoCo.PythonCall

glfw = mujoco.glfw.glfw
mj = mujoco
pc = MuJoCo.PythonCall

xml_path = "models/box.xml"
simend = 50

button_left = false
button_middle = false
button_right = false 
lastx = 0
lasty = 0

function init_controller(model, data)
end

function controller(model, data)
end

function keyboard(window, key, scandone, act, mods)
    if pc.pyconvert(Bool, act == glfw.PRESS) && pc.pyconvert(Bool, key == glfw.KEY_BACKSPACE)
        mj.mj_resetData(model, data)
        mj.mj_forward(model, data)
    end
end

function mouse_button(window, button, act, mods)
    global button_left, button_middle, button_right 

    button_left = glfw.get_mouse_button(window, glfw.MOUSE_BUTTON_LEFT) == glfw.PRESS 
    button_middle = glfw.get_mouse_button(window, glfw.MOUSE_BUTTON_MIDDLE) == glfw.PRESS 
    button_right = glfw.get_mouse_button(window, glfw.MOUSE_BUTTON_RIGHT) == glfw.PRESS 
    glfw.get_cursor_pos(window)
end

function mouse_move(window, xpos, ypos)
    global lastx, lasty, button_left, button_middle, button_right
    dx = xpos - lastx 
    dy = ypos - lasty 
    lastx = xpos 
    lasty = ypos 

    if (!pc.pyconvert(Bool, button_left)) && (!pc.pyconvert(Bool, button_middle)) && (!pc.pyconvert(Bool, button_right))
        return 
    end

    width, height = glfw.get_window_size(window)
    PRESS_LEFT_SHIFT = pc.pyconvert(Bool, glfw.get_key(window, glfw.KEY_LEFT_SHIFT) == glfw.PRESS)
    PRESS_RIGHT_SHIFT = pc.pyconvert(Bool, glfw.get_key(window, glfw.KEY_RIGHT_SHIFT) == glfw.PRESS)
    mod_shift = (PRESS_LEFT_SHIFT || PRESS_RIGHT_SHIFT)

    if pc.pyconvert(Bool, button_right)
        if pc.pyconvert(Bool, mod_shift)
            action = mj.mjtMouse.mjMOUSE_MOVE_H
        else
            action = mj.mjtMouse.mjMOUSE_MOVE_V
        end
    elseif pc.pyconvert(Bool, button_left)
        if pc.pyconvert(Bool, mod_shift)
            action = mj.mjtMouse.mjMOUSE_ROTATE_H
        else
            action = mj.mjtMouse.mjMOUSE_ROTATE_V 
        end
    else
        action = mj.mjtMouse.mjMOUSE_ZOOM 
    end
    mj.mjv_moveCamera(model, action, dx/height, dy/height, scene, cam)
end

function scroll(window, xoffset, yoffset)
    action = mj.mjtMouse.mjMOUSE_ZOOM 
    mj.mjv_moveCamera(model, action, 0.0, -0.05*yoffset, scene, cam)
end

# function main()
abspath = joinpath(@__DIR__, xml_path)
xml_path = abspath 

# if (!@isdefined model) model = mj.MjModel.from_xml_path(xml_path) end
# model = mj.MjModel.from_xml_path("examples/models/box.xml")
physics = mujoco.Physics.from_xml_path("examples/models/box.xml")
model = physics.model 
data = physics.data
# data = mj.MjData(model)
cam = mj.MjvCamera()
opt = mj.MjvOption()

glfw.init()
window = glfw.create_window(1200, 900, "Demo", nothing, nothing)
glfw.make_context_current(window)
glfw.swap_interval(1)

mj.mjv_defaultCamera(cam)
mj.mjv_defaultOption(opt)
scene = mj.MjvScene(model, maxgeom=10000)
context = mj.MjrContext(model, mj.mjtFontScale.mjFONTSCALE_150.value)

glfw.set_key_callback(window, keyboard)
glfw.set_cursor_pos_callback(window, mouse_move)
glfw.set_mouse_button_callback(window, mouse_button)
glfw.set_scroll_callback(window, scroll)

init_controller(model, data)
mj.set_mjcb_control(controller)

while (!(pc.pyconvert(Bool, glfw.window_should_close(window))))
    time_prev = data.time 
    while pc.pyconvert(Bool, (data.time - time_prev) < 1/60) mj.mj_step(model, data) end
    if pc.pyconvert(Bool, data.time > simend)  break end

    viewport_width, viewport_height = glfw.get_framebuffer_size(window)
    viewport = mj.MjrRect(0, 0, viewport_width, viewport_height)

    mj.mjv_updateScene(model, data, opt, nothing, cam, mj.mjtCatBit.mjCAT_ALL.value, scene)
    mj.mjr_render(viewport, scene, context)
    glfw.swap_buffers(window)
    glfw.poll_events()
end
glfw.terminate()
model = nothing 
data = nothing 
window = nothing
