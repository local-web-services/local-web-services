"""Given: an event source mapping has finished being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an event source mapping has finished being deleted")
def lambda_seq_esm_finished_deleting():
    pytest.skip("Cannot trigger ESM lifecycle transition in lws")
