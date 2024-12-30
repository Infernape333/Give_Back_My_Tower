class_name QuadTree

var ne: QuadTree = null
var nw: QuadTree = null
var se: QuadTree = null
var sw: QuadTree = null
var rect: Rect2
var is_leaf: bool = false
var there_is_leaf: bool = false
var leafs: Array[Rect2]

static func create_tree(tile_map_cells: Array[Rect2], cell_size: Vector2, max_height: int) -> QuadTree:
	var left = INF
	var right = -INF
	var up = INF
	var down = -INF
	
	for cell in tile_map_cells:
		left = min(left, cell.position.x)
		right = max(right, cell.position.x)
		up = min(up, cell.position.y)
		down = max(down, cell.position.y)
	
	var top_left_point: Vector2 = Vector2(left, up)
	var width_tree: float = right - left + cell_size.x
	var height_tree: float = down - up + cell_size.y
	
	return QuadTree.new(Rect2(top_left_point, Vector2(width_tree, height_tree)), tile_map_cells, cell_size, 0, max_height)
	
func _init(rect_tree: Rect2, cells: Array[Rect2], cell_size: Vector2, tree_height: float, max_height):
	var children_cells: Array[Rect2] = []
	
	rect = rect_tree
	for cell in cells:
		if (rect.intersects(cell)):
			children_cells.append(cell)
	
	if (children_cells.size() == 0):
		return
	else:
		there_is_leaf = true
	
	if (children_cells.size() <= 4 || tree_height >= max_height):
		is_leaf = true
		leafs.append_array(children_cells)
	else:
		var tree_pos: Vector2 = rect.position
		var half_size: Vector2 = rect.size / 2.0
		
		ne = QuadTree.new(Rect2(Vector2(tree_pos.x + half_size.x, tree_pos.y), half_size), children_cells, cell_size, tree_height + 1, max_height)
		nw = QuadTree.new(Rect2(tree_pos, half_size), children_cells, cell_size, tree_height + 1, max_height)
		se = QuadTree.new(Rect2(Vector2(tree_pos.x + half_size.x, tree_pos.y + half_size.y), half_size), children_cells, cell_size, tree_height + 1, max_height)
		sw = QuadTree.new(Rect2(Vector2(tree_pos.x, tree_pos.y + half_size.y), half_size), children_cells, cell_size, tree_height + 1, max_height)
	
		if (!ne.there_is_leaf):
			ne = null
		if (!nw.there_is_leaf):
			nw = null
		if (!se.there_is_leaf):
			se = null
		if (!sw.there_is_leaf):
			sw = null

func get_surrounding_cells (quad: Rect2) -> Dictionary:
	var nodes: Dictionary = {}
	
	if (is_leaf):
		for leaf in leafs:
			if (quad.intersects(leaf)):
				nodes[leaf] = null
	else:
		if (quad.intersects(rect)):
			if (ne != null):
				nodes.merge(ne.get_surrounding_cells(quad))
			if (nw != null):
				nodes.merge(nw.get_surrounding_cells(quad))
			if (se != null):
				nodes.merge(se.get_surrounding_cells(quad))
			if (sw != null):
				nodes.merge(sw.get_surrounding_cells(quad))
	
	return nodes
