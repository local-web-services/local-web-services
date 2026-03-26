"""Given: the event source mapping already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the event source mapping already exists")
def esm_already_exists():
    pytest.skip("Cannot pre-create event source mapping in lws")
