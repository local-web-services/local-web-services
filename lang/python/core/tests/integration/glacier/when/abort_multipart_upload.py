"""When: a multipart upload is aborted"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a multipart upload is aborted")
def abort_multipart_upload(client: TestClient, world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
