"""Given: the "lambda" "function" did not have a resource policy entry"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" did not have a resource policy entry')
def function_does_not_have_resource_policy_entry():
    """No-op: fresh state has no policy entries."""
