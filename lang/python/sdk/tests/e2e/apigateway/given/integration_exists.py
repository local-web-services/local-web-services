"""Given: the "api gateway" "integration" will exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "integration" will exist')
def integration_exists(lws_session):
    """No-op: integration existence is verified after setup in the test."""
