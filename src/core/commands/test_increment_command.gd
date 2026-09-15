class_name TestIncrementCommand
extends Command

## Minimal technical demonstration command used strictly to prove the
## Command -> Validation -> Mutation -> Event pipeline.
## Non-gameplay infrastructure only.

var amount: int = 0

func _init(p_amount: int = 1) -> void:
	amount = p_amount

func validate(state: GameState) -> CommandResult:
	if amount <= 0:
		return CommandResult.fail("Increment amount must be strictly positive.")
	if state.test_counter + amount > 100:
		return CommandResult.fail("Test counter cannot exceed maximum limit of 100.")
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	state.test_counter += amount
	return CommandResult.ok()
