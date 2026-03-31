"""When: a Glacier archive retrieval job is initiated on the "glacier" "vault" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_VAULT


@when('a Glacier archive retrieval job is initiated on the "glacier" "vault"')
def initiate_glacier_job(lws_session, world):
    try:
        resp = lws_session.client("glacier").initiate_job(
            accountId="-", vaultName=TEST_VAULT, jobParameters={"Type": "archive-retrieval"}
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
