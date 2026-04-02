"""Given: the target "sns" "topic" was "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target "sns" "topic" was "DELETED"')
def apigw_sns_target_topic_is_deleted():
    pytest.skip("Cannot simulate DELETED target topic in lws")
