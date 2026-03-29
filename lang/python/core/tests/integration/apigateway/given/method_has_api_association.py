"""Given: the method has an "API" association"""

from __future__ import annotations

from pytest_bdd import given


@given('the method has an "API" association')
def method_has_api_association():
    """No-op: methods always belong to an API in lws."""
