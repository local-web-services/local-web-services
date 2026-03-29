"""Then: a ParameterAlreadyExists error is recorded"""

from __future__ import annotations

from pytest_bdd import then


@then("a ParameterAlreadyExists error is recorded")
def parameter_already_exists_error(world):
    assert (
        world["error"] is not None
    ), "Expected a ParameterAlreadyExists error but no error was raised"
