"""Given: the "operation" does not have a header filter"""

from __future__ import annotations

from pytest_bdd import given


@given('the "operation" does not have a header filter')
def aws_fake_operation_does_not_have_header_filter():
    """No-op: add_operation adds a rule without a header filter by default."""
