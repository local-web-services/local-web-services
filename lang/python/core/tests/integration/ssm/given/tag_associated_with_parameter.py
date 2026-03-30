"""Given: the tag is associated with the parameter"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import SsmTestClient


@given("the tag is associated with the parameter")
def tag_associated_with_parameter(client: TestClient):
    SsmTestClient(client).add_tag()
