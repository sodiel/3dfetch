extends Node3D


@onready var camera_pivot = $CameraPivot
@onready var mesh_instance = $TextMeshInstance
@onready var logo = $Logo
#logos
@onready var manjaro = $Logos/manjaro
@onready var ubuntu = $Logos/ubuntu
@onready var tux = $Logos/tux

var sensetivity = 0.001
	
# var is_dragged = false

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# is_dragged = true
		#uncomment fow ewww
		#rotation.y = rotation.y - event.relative.x * sensetivity
		#rotation.x = rotation.x - event.relative.y * sensetivity
		camera_pivot.rotation.x = camera_pivot.rotation.x - event.relative.y * sensetivity
		camera_pivot.rotation.y = camera_pivot.rotation.y - event.relative.x * sensetivity

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if mesh_instance.mesh is TextMesh:
		
		var material = StandardMaterial3D.new()
		material.albedo_color = Color.YELLOW
		mesh_instance.set_surface_override_material(0, material)
		
		# Calling neofetch 
		var output = []
		var exit_code = OS.execute("neofetch", [], output)
		output = "".join(output)
		
		
		# Logo changing
		var distro = OS.get_distribution_name()
		if distro == "Manjaro Linux":
			manjaro.visible = true
		elif distro == "Ubuntu Linux":
			ubuntu.visible = true
		else:
			tux.visible = true 
			
		
		#get user name
		var username
		if OS.has_environment("USERNAME"):
			username = OS.get_environment("USERNAME")
		elif OS.has_environment("USER"):
			username = OS.get_environment("USER")
		else:
			username = ""
		#get host name
		var hostname = [""]
		OS.execute("hostname", [], hostname)
		hostname = "".join(hostname)
		var processor = OS.get_processor_name()
		var video = OS.get_video_adapter_driver_info()
		var environment = OS.get_environment("DESKTOP_SESSION")
		var memory = OS.get_memory_info()
		memory = str(memory["physical"] - memory["available"]) + 'out of' + str(memory["physical"])
		var text = username + '@' + hostname + "\n" + processor + "\n" + distro + "\n" + "".join(video) + "\n" 
		mesh_instance.mesh.text = text
	else:
		print("MeshInstance3D doesn't have TextMesh")

func _process(delta):
	# is_dragged = false
	var rotation_speed = 1
	# if not is_dragged:
	camera_pivot.rotation_degrees.y += delta * rotation_speed
	
