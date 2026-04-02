"""Then: a "ssm" "ParameterAlreadyExists" error will be recorded"""

from __future__ import annotations

from pytest_bdd import then


@then('a "ssm" "ParameterAlreadyExists" error will be recorded')
def parameter_already_exists_error(world):
    assert (
        world["error"] is not None
    ), "Expected a ParameterAlreadyExists error but no error was raised"
