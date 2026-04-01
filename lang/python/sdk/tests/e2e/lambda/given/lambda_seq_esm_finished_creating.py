"""Given: a "lambda" "event source mapping" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" "event source mapping" finishes creating')
def lambda_seq_esm_finished_creating():
    pytest.skip("Cannot trigger ESM lifecycle transition in lws")
