"""Given: the topic does not exist or is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the topic does not exist or is not "ACTIVE"')
def topic_not_exist_or_not_active():
    pytest.skip(
        "lws does not validate SNS topic existence when configuring ElastiCache notifications"
    )
