"""When: an archive is uploaded to a vault"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import GlacierTestClient
from ..constants import TEST_VAULT


@when("an archive is uploaded to a vault")
def upload_archive(lws_session, world):
    try:
        world["result"] = GlacierTestClient(lws_session).upload_archive(
            accountId="-", vaultName=TEST_VAULT, body=b"e2e-test-archive-data"
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
