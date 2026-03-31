"""Given: the "sqs" "queue" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given('the "sqs" "queue" already existed')
def queue_already_exists(client):
    SqsTestClient(client).create_queue()
