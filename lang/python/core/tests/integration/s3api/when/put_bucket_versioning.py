"""When: versioning is configured on a bucket"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_BUCKET


@when("versioning is configured on a bucket")
def put_bucket_versioning(sync_client: TestClient, world):
    r = sync_client.put(
        f"/{INT_BUCKET}",
        params={"versioning": ""},
        content=(
            b'<VersioningConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">'
            b"<Status>Enabled</Status></VersioningConfiguration>"
        ),
        headers={"Content-Type": "application/xml"},
    )
    if r.status_code in (200, 204):
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
