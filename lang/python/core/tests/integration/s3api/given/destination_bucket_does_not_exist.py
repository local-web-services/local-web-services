"""Given: the destination bucket does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the destination bucket does not exist")
def destination_bucket_does_not_exist():
    pytest.skip("Cannot remove destination bucket after source bucket is created.")
