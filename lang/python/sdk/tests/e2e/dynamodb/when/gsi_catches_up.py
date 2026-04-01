"""When: a "GSI" catches up with pending write propagation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "GSI" catches up with pending write propagation')
def gsi_catches_up(world):
    pytest.skip("Cannot trigger GSI propagation externally in lws")
