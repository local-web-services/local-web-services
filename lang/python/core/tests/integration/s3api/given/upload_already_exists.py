"""Given: the upload already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the upload already exists")
def upload_already_exists(world):
    pytest.skip("S3 allows multiple concurrent multipart uploads for the same key.")
