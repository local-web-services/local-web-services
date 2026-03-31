"""Given: the "sns" "topic" was "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sns" "topic" was "DELETED"')
def topic_is_deleted_given():
    pytest.skip("lws does not reject ElastiCache operations when the SNS topic is deleted")
