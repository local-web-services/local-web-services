"""Given: no cluster slot is available for the primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no cluster slot is available for the primary")
def no_cluster_slot_available_for_primary():
    pytest.skip("Cannot exhaust cluster slot limit in lws")
