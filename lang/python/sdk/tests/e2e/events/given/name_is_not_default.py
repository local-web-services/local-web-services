"""Given: name is not 'default'"""

from __future__ import annotations

from pytest_bdd import given


@given("name is not 'default'")
def name_is_not_default():
    """No-op: TEST_BUS is not the default bus."""
