"""When: a running execution calls an "ACTIVE" S3 Tables table and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running execution calls an "ACTIVE" S3 Tables table and the task succeeds')
def execution_calls_active_table_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that calls S3 Tables in lws")
