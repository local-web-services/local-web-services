"""Given: the configured topic is "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the configured topic is "DELETED"')
def configured_topic_is_deleted():
    pytest.skip("Cannot configure Glacier vault notifications in lws")
