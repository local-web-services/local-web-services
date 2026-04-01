"""Given: a "GSI" catches up with pending write propagation"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "GSI" catches up with pending write propagation')
def dynamodb_gsi_caught_up():
    pytest.skip("Cannot trigger GSI propagation as sequence setup in lws")
