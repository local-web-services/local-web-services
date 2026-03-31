"""When: a multipart "glacier" "upload" is completed"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a multipart "glacier" "upload" is completed')
def complete_multipart_upload(client: TestClient, world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
