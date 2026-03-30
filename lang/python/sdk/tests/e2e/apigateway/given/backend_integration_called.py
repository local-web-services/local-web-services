"""Given: a backend integration has been called"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a backend integration has been called")
def backend_integration_called():
    pytest.skip("Cannot represent a completed integration call as sequence setup in lws")
