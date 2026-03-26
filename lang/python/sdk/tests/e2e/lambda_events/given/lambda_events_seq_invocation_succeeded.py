"""Given: the Lambda function has published an event to the "ACTIVE" event bus and succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Lambda function has published an event to the "ACTIVE" event bus and succeeded')
def lambda_events_seq_invocation_succeeded():
    pytest.skip("Cannot trigger Lambda invocation in lws")
