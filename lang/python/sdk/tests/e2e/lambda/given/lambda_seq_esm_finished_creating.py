"""Given: an event source mapping has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an event source mapping has finished creating")
def lambda_seq_esm_finished_creating():
    pytest.skip("Cannot trigger ESM lifecycle transition in lws")
