"""Given: a running execution has read an existing object from the S3 bucket and succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has read an existing object from the S3 bucket and succeeded")
def running_execution_read_object_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution S3 read state for sequence setup")
