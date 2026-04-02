"""Given: a "api gateway" "backend integration" is called"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "api gateway" "backend integration" is called')
def backend_integration_called():
    pytest.skip("Cannot represent a completed integration call as sequence setup in lws")
