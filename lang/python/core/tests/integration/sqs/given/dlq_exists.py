"""Given: the dead-letter queue exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient
from ..constants import TEST_DLQ


@given("the dead-letter queue exists")
def dlq_exists(client):
    SqsTestClient(client).create_queue(TEST_DLQ)
