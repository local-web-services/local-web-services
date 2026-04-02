"""Given: the configured "sns" "topic" was not "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the configured "sns" "topic" was not "DELETED"')
def configured_topic_is_not_deleted():
    pytest.skip("Cannot configure Glacier vault notifications in lws")
