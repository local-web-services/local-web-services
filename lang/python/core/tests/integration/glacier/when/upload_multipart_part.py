"""When: a part is uploaded for a multipart "glacier" "upload" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a part is uploaded for a multipart "glacier" "upload"')
def upload_multipart_part(client: TestClient, world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
