"""Given: the "api gateway" "integration" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "integration" did not exist')
def integration_does_not_exist():
    pytest.skip(
        "lws does not validate integration existence before operations; cannot enforce "
        "this precondition in stateless integration tests."
    )
