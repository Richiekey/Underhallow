class_name CommandResult
extends RefCounted

## Typed result representing the outcome of a command validation or execution.

var success: bool = false
var error_message: String = ""

func _init(p_success: bool = false, p_error_message: String = "") -> void:
	success = p_success
	error_message = p_error_message

static func ok() -> CommandResult:
	return CommandResult.new(true, "")

static func fail(message: String) -> CommandResult:
	return CommandResult.new(false, message)
