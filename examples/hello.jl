using MuJoCo 

simple_MJCF = """
<mujoco>
<worldbody>
    <light name="top" pos="0 0 1"/>
    <body name="box" pos="0 0 1" euler="0 0 -30">
        <joint type="free" limited="false"/>
        <geom name="red_box" type="box" size=".2 .2 .2" rgba="1 0 0 1"/> 
    </body>
</worldbody>
</mujoco>
"""

physics = mujoco.Physics.from_xml_string(simple_MJCF)

for i=1:10
    physics.step()
    println(physics.data.qpos)
    sleep(1.0/240.0)
end