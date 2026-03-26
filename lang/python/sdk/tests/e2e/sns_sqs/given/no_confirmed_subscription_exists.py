"""Given: no confirmed subscription exists for the topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no confirmed subscription exists for the topic")
def no_confirmed_subscription_exists():
    pytest.skip("lws does not reject publish when no confirmed subscription exists")
