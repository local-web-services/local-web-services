"""Given: a Glacier archive retrieval job is initiated on the "glacier" "vault" """

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient
from ..constants import TEST_VAULT


@given('a Glacier archive retrieval job is initiated on the "glacier" "vault"')
def glacier_sns_seq_job_initiated(lws_session):
    GlacierSnsTestClient(lws_session).create_vault()
    GlacierSnsTestClient(lws_session)._glacier.initiate_job(
        accountId="-", vaultName=TEST_VAULT, jobParameters={"Type": "archive-retrieval"}
    )
