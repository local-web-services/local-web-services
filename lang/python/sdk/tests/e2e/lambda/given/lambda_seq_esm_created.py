"""Given: a "lambda" event source mapping is created"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" event source mapping is created')
def lambda_seq_esm_created():
    pytest.skip("Cannot create ESM in lws without a real event source ARN")
