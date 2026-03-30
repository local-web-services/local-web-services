"""Given: the queue exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("the queue exists")
def queue_exists(client):
    SqsTestClient(client).create_queue()
