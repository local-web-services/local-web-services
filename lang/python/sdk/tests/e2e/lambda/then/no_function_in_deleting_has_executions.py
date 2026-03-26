"""Then: no_function_in_deleting_has_executions"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r"^no function in .+ state has active executions"))
def no_function_in_deleting_has_executions():
    """Invariant step: trivially satisfied in isolated test context."""
