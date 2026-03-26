"""Given: the target topic is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target topic is not "ACTIVE"')
def apigw_sns_target_topic_is_not_active():
    pytest.skip("Cannot simulate non-ACTIVE target topic in lws")
