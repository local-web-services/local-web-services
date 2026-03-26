"""Given: the Lambda function has failed to publish because the event bus has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has failed to publish because the event bus has been deleted")
def lambda_events_seq_invocation_failed():
    pytest.skip("Cannot trigger Lambda invocation in lws")
