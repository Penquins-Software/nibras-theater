class_name RSEFrameCondition
extends RSEFrame


enum LogicalElement {
	## Оператор.
	OPERATOR,
	## Флаг.
	FLAG,
	## Переменная.
	VARIABLE,
	## Значение.
	VALUE,
	## Результат.
	RESULT,
}

enum Operator {
	## Равенство.
	EQUALITY,
	## Неравенство.
	INEQUALITY,
	## Больше.
	MORE,
	## Меньше.
	LESS,
	## Отрицание.
	NEGATION,
	## И.
	AND,
	## Исключающее ИЛИ.
	XOR,
	## ИЛИ.
	OR,
}


var condition: String


func get_frame_type() -> RSEFrame.FrameType:
	return RSEFrame.FrameType.Condition


func save_frame_to_dictionary() -> Dictionary:
	return {
		"type" : "RSEFrameCondition",
		"condition" : condition,
	}


func result(variables: Dictionary) -> bool:
	var logical_expression = parse_string()

	logical_expression = check_flags(variables, logical_expression)
	logical_expression = check_equality(variables, logical_expression)
	logical_expression = check_less_or_more(variables, logical_expression)
	logical_expression = check_negotation(variables, logical_expression)
	logical_expression = check_and(variables, logical_expression)
	logical_expression = check_or(variables, logical_expression)
	
	return logical_expression[0][1]


func parse_string() -> Array:
	var parts: PackedStringArray = condition.split(" ")

	var logical_expression: Array
	var variable: bool = false
	
	for index in parts.size():
		var type
		var value
		match parts[index]:
			"==":
				type = LogicalElement.OPERATOR
				value = Operator.EQUALITY
			"!=":
				type = LogicalElement.OPERATOR
				value = Operator.INEQUALITY
			"<":
				type = LogicalElement.OPERATOR
				value = Operator.LESS
			">":
				type = LogicalElement.OPERATOR
				value = Operator.MORE
			"NOT":
				type = LogicalElement.OPERATOR
				value = Operator.NEGATION
			"AND":
				type = LogicalElement.OPERATOR
				value = Operator.AND
			"OR":
				type = LogicalElement.OPERATOR
				value = Operator.OR
			_:
				if variable:
					variable = false
					value = parts[index]
					if value.is_valid_float():
						type = LogicalElement.VALUE
					else:
						type = LogicalElement.VARIABLE
				else:
					if index + 1 < parts.size():
						var next_part = parts[index + 1]
						if next_part == "==" or next_part == "!=" or next_part == ">" or next_part == "<":
							variable = true
							type = LogicalElement.VARIABLE
							value = parts[index]
						else:
							variable = false
							type = LogicalElement.FLAG
							value = parts[index]
					else:
						variable = false
						type = LogicalElement.FLAG
						value = parts[index]
		
		logical_expression.append([type, value])
	
	return logical_expression


func check_flags(variables: Dictionary, logical_expression: Array) -> Array:
	var new_logical_expression: Array
	
	for element in logical_expression:
		if element[0] == LogicalElement.FLAG:
			var result = variables["Flags"].has(element[1]) || variables.has(element[1])
			new_logical_expression.append([LogicalElement.RESULT, result])
		else:
			new_logical_expression.append(element)
	
	return new_logical_expression


func check_equality(variables: Dictionary, logical_expression: Array) -> Array:
	var new_logical_expression: Array

	var variable: String
	var operator: Operator

	var index: int = 0
	
	for element in logical_expression:
		new_logical_expression.append(element)
	
		if element[0] == LogicalElement.VARIABLE:
			variable = element[1]
		
		elif element[0] == LogicalElement.OPERATOR:
			operator = element[1]
		
		elif element[0] == LogicalElement.VALUE:
			if operator == Operator.EQUALITY:
				var result = variables.has(variable)
				if result:
					result = variables[variable] == float(element[1])
				new_logical_expression.pop_at(index)
				new_logical_expression.pop_at(index - 1)
				new_logical_expression.pop_at(index - 2)
				index -= 2
				new_logical_expression.append([LogicalElement.RESULT, result])
			
			elif operator == Operator.INEQUALITY:
				var result = variables.has(variable)
				if result:
					result = variables[variable] == float(element[1])
				result = not result
				new_logical_expression.pop_at(index)
				new_logical_expression.pop_at(index - 1)
				new_logical_expression.pop_at(index - 2)
				index -= 2
				new_logical_expression.append([LogicalElement.RESULT, result])
		index += 1
	
	return new_logical_expression


func check_less_or_more(variables: Dictionary, logical_expression: Array) -> Array:
	var new_logical_expression: Array

	var variable: String
	var operator: Operator

	var index: int = 0
	
	for element in logical_expression:
		new_logical_expression.append(element)
	
		if element[0] == LogicalElement.VARIABLE:
			variable = element[1]
		
		elif element[0] == LogicalElement.OPERATOR:
			operator = element[1]
		
		elif element[0] == LogicalElement.VALUE:
			if operator == Operator.LESS:
				var result = variables.has(variable)
				if result:
					result = variables[variable] < float(element[1]) 
				new_logical_expression.pop_at(index)
				new_logical_expression.pop_at(index - 1)
				new_logical_expression.pop_at(index - 2)
				index -= 2
				new_logical_expression.append([LogicalElement.RESULT, result])
			
			elif operator == Operator.MORE:
				var result = variables.has(variable)
				if result:
					result = variables[variable] > float(element[1])
				new_logical_expression.pop_at(index)
				new_logical_expression.pop_at(index - 1)
				new_logical_expression.pop_at(index - 2)
				index -= 2
				new_logical_expression.append([LogicalElement.RESULT, result])
		index += 1
	
	return new_logical_expression


func check_negotation(variables: Dictionary, logical_expression: Array) -> Array:
	var new_logical_expression: Array

	var operator: Operator = 0

	var index: int = 0

	for element in logical_expression:
		new_logical_expression.append(element)

		if operator == Operator.NEGATION:
			if element[0] == LogicalElement.RESULT:
				new_logical_expression.pop_at(index)
				new_logical_expression.pop_at(index - 1)
				index -= 2
				new_logical_expression.append([LogicalElement.RESULT, not element[1]])
		
		if element[0] == LogicalElement.OPERATOR:
			operator = element[1]
		
		index += 1

	return new_logical_expression


func check_and(variables: Dictionary, logical_expression: Array) -> Array:
	var new_logical_expression: Array

	var prev_result: bool = false
	var operator: Operator = 0

	var index: int = 0

	for element in logical_expression:
		new_logical_expression.append(element)

		if operator == Operator.AND:
			if element[0] == LogicalElement.RESULT:
				new_logical_expression.pop_at(index)
				new_logical_expression.pop_at(index - 1)
				new_logical_expression.pop_at(index - 2)
				index -= 2
				prev_result = prev_result && element[1]
				new_logical_expression.append([LogicalElement.RESULT, prev_result])
		
		if element[0] == LogicalElement.OPERATOR:
			operator = element[1]
		
		if element[0] == LogicalElement.RESULT:
			prev_result = element[1]
		
		index += 1

	return new_logical_expression


func check_or(variables: Dictionary, logical_expression: Array) -> Array:
	var new_logical_expression: Array

	var prev_result: bool = false
	var operator: Operator = 0

	var index: int = 0

	for element in logical_expression:
		new_logical_expression.append(element)

		if operator == Operator.OR:
			if element[0] == LogicalElement.RESULT:
				new_logical_expression.pop_at(index)
				new_logical_expression.pop_at(index - 1)
				new_logical_expression.pop_at(index - 2)
				index -= 2
				prev_result = prev_result || element[1]
				new_logical_expression.append([LogicalElement.RESULT, prev_result])
		
		if element[0] == LogicalElement.OPERATOR:
			operator = element[1]
		
		if element[0] == LogicalElement.RESULT:
			prev_result = element[1]
		
		index += 1

	return new_logical_expression
