"""Given: the "glacier" "upload" already existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3" "upload" already existed')
@given('the "glacier" "upload" already existed')
def upload_already_exists(world):
    pytest.skip("S3 allows multiple concurrent multipart uploads for the same key.")
