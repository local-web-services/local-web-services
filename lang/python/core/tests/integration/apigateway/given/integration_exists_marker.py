"""Given: the "api gateway" "integration" will exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "integration" will exist')
def integration_exists_marker():
    """No-op: integration existence is set up by other Given steps."""
