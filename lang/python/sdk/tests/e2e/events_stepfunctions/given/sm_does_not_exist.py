"""Given: the state machine does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the state machine does not exist")
def sm_does_not_exist():
    pytest.skip("lws does not validate state machine target existence when creating a rule")
