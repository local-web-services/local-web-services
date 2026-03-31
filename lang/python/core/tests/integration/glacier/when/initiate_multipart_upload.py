"""When: a multipart "glacier" "upload" is initiated for a "glacier" "vault" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a multipart "glacier" "upload" is initiated for a "glacier" "vault"')
def initiate_multipart_upload(client: TestClient, world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
