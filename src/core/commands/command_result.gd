class_name CommandResult
extends RefCounted

## Typed result representing the outcome of a command validation or execution.

var success: bool = false
var message: String = ""
var error_message: String:
	get:
		return message if not success else ""
	set(val):
		message = val

func _init(p_success: bool = false, p_message: String = "") -> void:
	success = p_success
	message = p_message

static func ok(p_message: String = "") -> CommandResult:
	return CommandResult.new(true, p_message)

static func fail(p_message: String) -> CommandResult:
	return CommandResult.new(false, p_message)
