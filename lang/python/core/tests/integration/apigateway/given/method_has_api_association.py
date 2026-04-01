"""Given: the "api gateway" "method" has an "api gateway" "API" association"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "method" has an "api gateway" "API" association')
def method_has_api_association():
    """No-op: methods always belong to an API in lws."""
