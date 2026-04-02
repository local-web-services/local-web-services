"""Given: a "glacier" "vault" inventory retrieval job is initiated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierTestClient
from ..constants import TEST_VAULT


@given('a "glacier" "vault" inventory retrieval job is initiated')
def glacier_seq_inventory_retrieval_initiated(lws_session):
    GlacierTestClient(lws_session).create_vault()
    GlacierTestClient(lws_session).initiate_job(
        accountId="-",
        vaultName=TEST_VAULT,
        jobParameters={"Type": "inventory-retrieval"},
    )
