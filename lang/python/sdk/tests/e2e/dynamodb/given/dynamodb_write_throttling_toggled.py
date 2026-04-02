"""Given: "dynamodb" "write" throttling is toggled on or off"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('"dynamodb" "write" throttling is toggled on or off')
def dynamodb_write_throttling_toggled():
    pytest.skip("Cannot toggle write throttling as sequence setup in lws")
