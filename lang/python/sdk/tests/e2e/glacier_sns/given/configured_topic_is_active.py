"""Given: the configured topic is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the configured topic is "ACTIVE"')
def configured_topic_is_active():
    pytest.skip("Cannot configure Glacier vault notifications in lws")
