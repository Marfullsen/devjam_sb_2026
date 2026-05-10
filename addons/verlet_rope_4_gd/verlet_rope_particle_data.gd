class_name RopeParticleData

# Data structure for an individual rope particle
class RopeParticle:
	var position_previous: Vector3
	var position_current: Vector3
	var acceleration: Vector3
	var is_attached: bool = false
	var tangent: Vector3 = Vector3.ZERO
	var normal: Vector3 = Vector3.ZERO
	var binormal: Vector3 = Vector3.ZERO

	func _init():
		position_previous = Vector3.ZERO
		position_current = Vector3.ZERO
		acceleration = Vector3.ZERO
		is_attached = false
		tangent = Vector3.ZERO
		normal = Vector3.ZERO
		binormal = Vector3.ZERO

# Particle array
var particles: Array[RopeParticle] = []

# Factory method
static func generate_particle_data(end_location: Vector3, global_position: Vector3, initial_acceleration: Vector3, simulationparticles: int, segment_length: float) -> RopeParticleData:
	var direction = (end_location - global_position).normalized()
	var data: Array[RopeParticle] = []
	for i in simulationparticles:
		var particle := RopeParticle.new()
		var position = global_position + direction * segment_length * i
		particle.position_previous = position
		particle.position_current = position
		particle.acceleration = initial_acceleration
		particle.is_attached = false
		data.append(particle)
	var instance = RopeParticleData.new()
	instance.particles = data
	return instance

# Resize array (with new empty particles if expanded)
func resize(size: int) -> void:
	var current_size = particles.size()
	if size > current_size:
		for i in size - current_size:
			particles.append(RopeParticle.new())
	else:
		particles.resize(size)

# Indexing helper (no reference return, GDScript passes by value)
func get_particle(index: int) -> RopeParticle:
	return particles[index]

func set_particle(index: int, value: RopeParticle) -> void:
	particles[index] = value
