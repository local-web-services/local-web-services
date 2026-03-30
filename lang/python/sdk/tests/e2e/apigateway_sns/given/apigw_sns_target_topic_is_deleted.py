"""Given: the target topic is "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target topic is "DELETED"')
def apigw_sns_target_topic_is_deleted():
    pytest.skip("Cannot simulate DELETED target topic in lws")
