"""Given: the target queue is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target queue is not "ACTIVE"')
def apigw_sqs_target_queue_is_not_active():
    pytest.skip("Cannot simulate non-ACTIVE target queue in lws")
