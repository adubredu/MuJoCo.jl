using MuJoCo 

simple_MJCF = """
<mujoco>
<worldbody>
    <light name="top" pos="0 0 1"/>
    <geom type="plane" size="1 1 0.1" rgba=".7 .7 .7 1"/>
    <body name="box" pos="0 0 1" euler="0 0 -30">
        <joint type="free"/>
        <geom name="red_box" type="box" size=".2 .2 .2" rgba="1 0 0 1"/> 
    </body>
</worldbody>
</mujoco>
"""
viewer = mujoco.viewer 

model = mujoco.MjModel.from_xml_string(simple_MJCF)
data = mujoco.MjData(model)
viewer.launch_repl(model, data)

for i=1:1000
    mj_step(model, data)
    sleep(1.0/240.0)
end
