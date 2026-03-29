"""Given: an event source mapping has been created"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an event source mapping has been created")
def lambda_seq_esm_created():
    pytest.skip("Cannot create ESM in lws without a real event source ARN")
