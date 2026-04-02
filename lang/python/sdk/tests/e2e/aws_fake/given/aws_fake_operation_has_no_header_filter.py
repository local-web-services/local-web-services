"""Given: the "operation" has no header filter"""

from __future__ import annotations

from pytest_bdd import given


@given('the "operation" has no header filter')
def aws_fake_operation_has_no_header_filter():
    """No-op: add_operation adds a rule without a header filter by default."""
