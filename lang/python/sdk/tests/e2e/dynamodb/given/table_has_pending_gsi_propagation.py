"""Given: the "dynamodb" "table" had pending "GSI" propagation"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "dynamodb" "table" had pending "GSI" propagation')
def table_has_pending_gsi_propagation():
    pytest.skip("Cannot configure GSI propagation in this abstract context")
