"""Given: the tag was associated with the "ssm" "parameter" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import SsmTestClient


@given('the tag was associated with the "ssm" "parameter"')
def tag_associated_with_parameter(client: TestClient):
    SsmTestClient(client).add_tag()
