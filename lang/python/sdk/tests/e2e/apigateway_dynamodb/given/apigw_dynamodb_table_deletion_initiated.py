"""Given: a table deletion has been initiated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayDynamodbTestClient
from ..constants import TEST_TABLE


@given("a table deletion has been initiated")
def apigw_dynamodb_table_deletion_initiated(lws_session):
    ApigatewayDynamodbTestClient(lws_session).create_table()
    ApigatewayDynamodbTestClient(lws_session)._dynamodb.delete_table(TableName=TEST_TABLE)
