"""When: a running "step functions" "execution" fails because the S3 Tables table is being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running "step functions" "execution" fails because the S3 Tables table is being deleted')
def execution_fails_table_deleting(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to S3 Tables table deletion in lws"
    )
