"""Given: the "API" does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "API" does not exist')
def api_does_not_exist():
    pytest.skip(
        "lws does not validate API existence before deployment; cannot enforce this "
        "precondition in stateless integration tests."
    )
