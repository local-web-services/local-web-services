"""When: a "api gateway" "deployment" is deleted when no stage references it"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "api gateway" "deployment" is deleted when no stage references it')
def delete_deployment(client: TestClient, world):
    pytest.skip(
        "lws has no route for DELETE /restapis/{id}/deployments/{id}; deployment "
        "deletion is not yet implemented."
    )
