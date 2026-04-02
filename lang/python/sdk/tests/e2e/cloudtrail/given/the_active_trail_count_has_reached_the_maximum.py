"""Given: the active trail count has reached the maximum (5)"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient
from ..constants import TEST_BUCKET, TEST_TRAIL


@given('the "cloudtrail" "trail" count has reached the maximum (5)')
@given("the active trail count has reached the maximum (5)")
def the_active_trail_count_has_reached_the_maximum(lws_session):
    client = CloudtrailTestClient(lws_session)
    for i in range(1, 6):
        client.create_trail(name=f"{TEST_TRAIL}-max-{i}", bucket=f"{TEST_BUCKET}-max-{i}")
