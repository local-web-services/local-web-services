"""Given: no record slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no record slot is available")
def lambda_s3tables_no_record_slot_available():
    pytest.skip("Cannot exhaust record slot limit")
