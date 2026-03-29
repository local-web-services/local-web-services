"""Given: name in gsi_pending"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("name in gsi_pending")
def dynamodb_name_in_gsi_pending():
    pytest.skip("Cannot configure GSI propagation state as sequence setup in lws")
