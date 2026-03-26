"""Given: no invocation slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no invocation slot is available")
def lambda_s3tables_no_invocation_slot_available():
    pytest.skip("Cannot exhaust invocation slot limit")
