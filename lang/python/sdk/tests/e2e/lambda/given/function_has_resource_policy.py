"""Given: the function has a resource policy"""

from __future__ import annotations

from pytest_bdd import given


@given("the function has a resource policy")
def function_has_resource_policy():
    """No-op: policy already added by resource policy entry step."""
