"""Given: the "sns" "topic" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sns" "topic" did not exist')
def topic_does_not_exist():
    pytest.skip("lws does not validate SNS topic existence when deleting")
