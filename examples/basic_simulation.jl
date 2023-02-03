using MuJoCo 

xml_path = joinpath(@__DIR__, "models/humanoid.xml")

physics = mujoco.Physics.from_xml_path(xml_path)

for i=1:10
    physics.step()
    println(physics.data.qpos)
    println(physics.data.qvel)
    println("===")
    sleep(1.0/240.0)
end