extends Node2D

class_name Map

var current_node = null

func get_valid_paths() -> Array[MapNode]:
	if current_node == null:
		return []
	
	return current_node.neighbors

@export var start_pos : Node2D

@export var max_nodes : int = 5
@export var max_neighbors : int = 3

@export var min_distance : float = 50
@export var max_distance : float = 200

@onready var _lines: Node2D = $Lines
@onready var _nodes: Node2D = $Nodes

const MAP_NODE_PREFAB = preload("res://Objects/Map_Node.tscn")

var nodes : Array[MapNode] = []

var edges : Array[Array] = []
var edge_paths : Array[Path2D] = []

func generate_nodes() -> void:
	var points : Array[Vector2] = [start_pos.position]
	var domain_size = sqrt(max_nodes) * max_distance
	
	var attempts = 0
	while len(points) < max_nodes and attempts < 30 * max_nodes:
		attempts += 1
		var p = Vector2(randf_range(0, domain_size) + start_pos.position.x, randf_range(0, domain_size) + start_pos.position.y)
		
		var ok = true
		for point in points:
			if point.distance_to(p) < min_distance:
				ok = false
				break
		
		if ok:
			points.append(p)
	
	for point in points:
		nodes.append(_create_node(point))
		print("%s %s" % [point.x, point.y])

func _create_node(pos: Vector2) -> MapNode:
	var node : MapNode = MAP_NODE_PREFAB.instantiate()
	_nodes.add_child(node)
	node.set_node_position(pos)
	return node

func build_connections() -> void:
	var n = len(nodes)
	
	for u in range(n):
		if len(nodes[u].neighbors) >= max_neighbors:
			continue
		
		var candidates = []
		for v in range(n):
			if v == u or len(nodes[v].neighbors) >= max_neighbors:
				continue
			
			var d = nodes[u].position.distance_to(nodes[v].position)
			if min_distance <= d and d <= max_distance:
				candidates.append([d, v])
			
		candidates.sort_custom(func(a, b): return a[0] < b[0])
		
		for c in candidates:
			var v = c[1]
			if len(nodes[v].neighbors) >= max_neighbors or len(nodes[u].neighbors) >= max_neighbors:
				continue
			
			var edge = [min(u, v), max(u, v)]
			if edge not in edges:
				edges.append(edge)
				nodes[v].neighbors.append(nodes[u])
				nodes[u].neighbors.append(nodes[v])	

func draw_edges() -> void:
	for edge in edges:
		edge_paths.append(_create_edge(nodes[edge[0]].position, nodes[edge[1]].position))

func ensure_connected() -> void:
	var n = len(nodes)
	var parent = Array(range(n))
	
	var find = func find(x) -> int:
		while parent[x] != x:
			parent[x] = parent[parent[x]]
			x = parent[x]
		return x
	
	var union = func union(a, b):
		var ra : int = find.call(a)
		var rb : int = find.call(b)
		if ra != rb:
			parent[rb] = ra
	
	for edge in edges:
		union.call(edge[0], edge[1])
	
	while true:
		var components : Dictionary[int, Array] = {}
		
		for i in range(n):
			var f = find.call(i)
			if not components.has(f):
				components[f] = []
			components[f].append(i)
		
		if len(components) == 1:
			return
		
		var comps = Array(components.values())
		var best = null
		
		for i in range(len(comps)):
			for j in range(i + 1, len(comps)):
				for u in comps[i]:
					if len(nodes[u].neighbors) >= max_neighbors:
						continue
					for v in comps[j]:
						if len(nodes[v].neighbors) >= max_neighbors:
							continue
						var d = nodes[u].position.distance_to(nodes[v].position)
						if d <= max_distance:
							if best == null or d < best[0]:
								best = [d, u, v]
		assert(best == null, "Not possible with current parameters")
		var u = best[1]
		var v = best[2]
		var edge = [min(u, v), max(u, v)]
		if edge not in edges:
			edges.append(edge)
			nodes[v].neighbors.append(nodes[u])
			nodes[u].neighbors.append(nodes[v])
		
		union.call(u, v)

func _create_edge(a : Vector2, b: Vector2) -> Path2D:
	var path = Path2D.new()
	path.curve = Curve2D.new()
	path.curve.add_point(a)
	path.curve.add_point(b)
	var line = Line2D.new()
	line.add_point(a)
	line.add_point(b)
	_lines.add_child(line)
	return path

func _ready() -> void:
	generate_nodes()
	#build_connections()
	ensure_connected()
	draw_edges()
