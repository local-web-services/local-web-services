"""Given: the integration "EXISTS" """

from __future__ import annotations

from pytest_bdd import given


@given('the integration "EXISTS"')
def integration_exists_marker():
    """No-op: integration existence is set up by other Given steps."""
