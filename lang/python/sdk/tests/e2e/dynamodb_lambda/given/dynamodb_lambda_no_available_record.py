"""Given: no "AVAILABLE" "dynamodb" "record" existed in the mapped table's stream"""

from __future__ import annotations

from pytest_bdd import given


@given('no "AVAILABLE" "dynamodb" "record" existed in the mapped table\'s stream')
@given('no "AVAILABLE" record existed in the mapped table\'s stream')
def dynamodb_lambda_no_available_record(world):
    """No-op: fresh state has no stream records."""
    world["stream_record_available"] = False
