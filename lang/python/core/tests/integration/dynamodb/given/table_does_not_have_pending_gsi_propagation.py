"""Given: the table does not have pending "GSI" propagation"""

from __future__ import annotations

from pytest_bdd import given


@given('the table does not have pending "GSI" propagation')
def table_does_not_have_pending_gsi_propagation():
    """No-op: no GSI propagation is configured by default."""
