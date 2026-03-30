"""Given: the method does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the method does not exist")
def method_does_not_exist():
    pytest.skip(
        "lws does not validate method existence before operations; cannot enforce this "
        "precondition in stateless integration tests."
    )
