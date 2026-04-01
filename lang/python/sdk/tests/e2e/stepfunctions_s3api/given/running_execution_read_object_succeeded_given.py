"""Given: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds'
)
def running_execution_read_object_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution S3 read state for sequence setup")
