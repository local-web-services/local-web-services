"""Given: no "AVAILABLE" record exists in the mapped table's stream"""

from __future__ import annotations

from pytest_bdd import given


@given('no "AVAILABLE" record exists in the mapped table\'s stream')
def dynamodb_lambda_no_available_record():
    """No-op: fresh state has no stream records."""
