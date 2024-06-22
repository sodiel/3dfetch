extends Node3D


@onready var camera_pivot = $CameraPivot
@onready var mesh_instance = $TextMeshInstance
@onready var logo = $Logo


func _ready():
	if mesh_instance.mesh is TextMesh:
		
		var material = StandardMaterial3D.new()
		material.albedo_color = Color.INDIAN_RED
		mesh_instance.set_surface_override_material(0, material)
		
		# Calling neofetch 
		var output = []
		var exit_code = OS.execute("neofetch", [], output)
		output = "".join(output)
		
		
		# Logo changing
		var distro = OS.get_distribution_name()
		logo.mesh = load("res://logos/logo_placeholder.tres")
		
		
		var processor = OS.get_processor_name()
		var video = OS.get_video_adapter_driver_info()
		var environment = OS.get_environment("DESKTOP_SESSION")
		var memory = OS.get_memory_info()
		memory = str(memory["physical"] - memory["available"]) + 'out of' + str(memory["physical"])
		var text = processor + "\n" + distro + "\n" + "".join(video) + "\n" + memory + "\n" 
		mesh_instance.mesh.text = text
	else:
		print("MeshInstance3D doesn't have TextMesh")
		
func _process(delta):
	var rotation_speed = 10
	camera_pivot.rotation_degrees.y += delta * rotation_speed
	
