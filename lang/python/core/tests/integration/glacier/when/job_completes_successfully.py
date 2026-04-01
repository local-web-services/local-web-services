"""When: a "glacier" "job" completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "glacier" "job" completes successfully')
def job_completes_successfully(client: TestClient, world):
    pytest.skip(
        "Job completion transitions are not supported in the stateless lws Glacier provider."
    )
