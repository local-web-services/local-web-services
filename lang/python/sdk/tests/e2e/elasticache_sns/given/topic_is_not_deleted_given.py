"""Given: the "sns" "topic" was not "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sns" "topic" was not "DELETED"')
def topic_is_not_deleted_given():
    pytest.skip("lws does not enforce notification failure when the topic is not deleted")
