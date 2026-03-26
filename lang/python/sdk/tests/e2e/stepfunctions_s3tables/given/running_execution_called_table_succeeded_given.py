"""Given: a running execution has called an "ACTIVE" S3 Tables table and the task succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running execution has called an "ACTIVE" S3 Tables table and the task succeeded')
def running_execution_called_table_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution S3 Tables task state for sequence setup")
