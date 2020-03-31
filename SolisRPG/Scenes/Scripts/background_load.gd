extends CanvasLayer

const SIMULATED_DELAY_SEC = 0.1 	

var thread = null

onready var progress = ProgressBar
onready var background = $Background
var alpha: float = 0
var fading: bool = false
var destinationScene

func _ready():
	progress = get_node("Progress")
	background.color = Color(0,0,0, alpha)

func _thread_load(path):
	var ril = ResourceLoader.load_interactive(path)
	assert(ril)
	var total = ril.get_stage_count()
	# Call deferred to configure max load steps.
	progress.call_deferred("set_max", total)
	
	var res = null
	
	while true: #iterate until we have a resource
		# Update progress bar, use call deferred, which routes to main thread.
		progress.call_deferred("set_value", ril.get_stage())
		
		# Poll (does a load step).
		var err = ril.poll()
		# If OK, then load another one. If EOF, it' s done. Otherwise there was an error.
		if err == ERR_FILE_EOF:
			# Loading done, fetch resource.
			res = ril.get_resource()
			break
		elif err != OK:
			# Not OK, there was an error.
			print("There was an error loading")
			break
	
	# Send whathever we did (or did not) get.
	call_deferred("_thread_done", res)


func _thread_done(resource):
	assert(resource)
	
	# Always wait for threads to finish, this is required on Windows.
	thread.wait_to_finish()
	
	# Hide the progress bar.
	progress.hide()
	
	
	# Instantiate new scene.
	var new_scene = resource.instance()
	# Free current scene.
	get_tree().current_scene.free()
	get_tree().current_scene = null
	# Add new one to root.
	get_tree().root.add_child(new_scene)
	# Set as current scene.
	get_tree().current_scene = new_scene
	get_tree().current_scene.get_tree().paused = false
	set_process(true)
	progress.visible = false

func load_scene(path):
	destinationScene = path
	#thread = Thread.new()
	get_tree().current_scene.get_tree().paused = true
	raise()
	Ui.raise()
	background.visible = true
	fading = true
	set_process(true)

func _process(delta):
	if(fading):
		alpha += delta*3
		background.color = Color(0,0,0,alpha)
		if(alpha >= 1):
			fading = false
			thread = Thread.new()
			thread.start(self, "_thread_load", destinationScene)
			raise()
			progress.visible = true
			set_process(false)
			
	if(!fading):
		alpha -= delta*3
		background.color = Color(0,0,0,alpha)
		if(alpha <= 0):
			fading = true
			background.visible = false
			background.hide()
			set_process(false)
		
		
	
	
