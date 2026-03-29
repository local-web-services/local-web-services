"""Given: rid not in resource_api"""

from __future__ import annotations

from pytest_bdd import given


@given("rid not in resource_api")
def rid_not_in_resource_api():
    """No-op: fresh state has no resources."""
