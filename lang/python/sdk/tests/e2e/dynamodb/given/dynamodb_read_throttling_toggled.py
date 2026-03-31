"""Given: read throttling is toggled on or off"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("read throttling is toggled on or off")
def dynamodb_read_throttling_toggled():
    pytest.skip("Cannot toggle read throttling as sequence setup in lws")
