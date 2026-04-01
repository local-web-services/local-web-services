"""Given: a running "step functions" "execution" fails because the S3 Tables table is being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running "step functions" "execution" fails because the S3 Tables table is being deleted')
def running_execution_failed_table_deleting_given():
    pytest.skip("Cannot pre-set a failed execution S3 Tables task state for sequence setup")
