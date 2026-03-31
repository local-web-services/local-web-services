"""Given: a "api gateway" "method" is deleted along with its integration"""

from __future__ import annotations

from pytest_bdd import given


@given('a "api gateway" "method" is deleted along with its integration')
def method_deleted_with_integration():
    """No-op: method deletion is part of API setup in the test."""
