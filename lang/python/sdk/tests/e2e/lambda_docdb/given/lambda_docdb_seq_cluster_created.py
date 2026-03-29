"""Given: a DocumentDB cluster has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaDocdbTestClient


@given("a DocumentDB cluster has been created")
def lambda_docdb_seq_cluster_created(lws_session):
    LambdaDocdbTestClient(lws_session).create_cluster()
