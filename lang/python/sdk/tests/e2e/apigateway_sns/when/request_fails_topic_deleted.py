"""When: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted'
)
def request_fails_topic_deleted(world):
    pytest.skip("Cannot simulate SNS publish failure on deleted topic via API Gateway in lws")
