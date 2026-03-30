"""Given: the topic is "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the topic is "DELETED"')
def topic_is_deleted_given():
    pytest.skip("lws does not reject ElastiCache operations when the SNS topic is deleted")
