"""Given: the table has pending "GSI" propagation"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the table has pending "GSI" propagation')
def table_has_pending_gsi_propagation():
    pytest.skip("GSI propagation is not configurable in integration context")
