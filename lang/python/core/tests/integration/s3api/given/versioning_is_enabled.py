"""Given: versioning is enabled"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@given("versioning is enabled")
def versioning_is_enabled(sync_client: TestClient):
    sync_client.put(
        f"/{INT_BUCKET}",
        params={"versioning": ""},
        content=(
            b'<VersioningConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">'
            b"<Status>Enabled</Status></VersioningConfiguration>"
        ),
        headers={"Content-Type": "application/xml"},
    )
