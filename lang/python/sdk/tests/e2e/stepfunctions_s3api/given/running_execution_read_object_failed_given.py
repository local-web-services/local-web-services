"""Given: a running "step functions" "execution" fails to read because no object exists in the bucket"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" fails to read because no object exists in the bucket'
)
def running_execution_read_object_failed_given():
    pytest.skip("Cannot pre-set a failed execution S3 read state for sequence setup")
