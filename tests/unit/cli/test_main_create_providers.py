"""Unit tests for ldk CLI main module."""

from __future__ import annotations

from lws.cli.ldk import (
    _create_providers,
)
from lws.config.loader import LdkConfig
from lws.graph.builder import build_graph
from lws.parser.assembly import (
    AppModel,
    DynamoTable,
    LambdaFunction,
)


class TestCreateProviders:
    """Tests for _create_providers."""

    def test_creates_dynamo_provider(self, tmp_path):
        app_model = AppModel(
            tables=[
                DynamoTable(
                    name="TestTable",
                    key_schema=[{"attribute_name": "id", "type": "S", "key_type": "HASH"}],
                )
            ],
        )
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, _chaos_configs, _ = _create_providers(app_model, graph, config, tmp_path)

        # Should have the dynamo table provider + dynamo HTTP provider
        assert "__dynamodb_http__" in providers

    def test_creates_lambda_providers(self, tmp_path):
        app_model = AppModel(
            functions=[
                LambdaFunction(
                    name="MyFunc",
                    handler="index.handler",
                    runtime="nodejs20.x",
                    code_path=tmp_path,
                )
            ],
        )
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, _chaos_configs, _ = _create_providers(app_model, graph, config, tmp_path)

        # Should have at least the Lambda provider
        assert any(p.name.startswith("lambda:") for p in providers.values())

    def test_empty_model_still_has_dynamodb(self, tmp_path):
        app_model = AppModel()
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, _chaos_configs, _ = _create_providers(app_model, graph, config, tmp_path)

        # DynamoDB HTTP is always available (for Terraform/CLI table creation)
        assert "__dynamodb_http__" in providers

    def test_empty_model_still_has_sqs(self, tmp_path):
        app_model = AppModel()
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, _chaos_configs, _ = _create_providers(app_model, graph, config, tmp_path)

        # SQS HTTP is always available (for Terraform/CLI queue creation)
        assert "__sqs_http__" in providers

    def test_empty_model_still_has_s3(self, tmp_path):
        app_model = AppModel()
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, _chaos_configs, _ = _create_providers(app_model, graph, config, tmp_path)

        # S3 HTTP is always available (for Terraform/CLI bucket creation)
        assert "__s3_http__" in providers

    def test_empty_model_still_has_sns(self, tmp_path):
        app_model = AppModel()
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, _chaos_configs, _ = _create_providers(app_model, graph, config, tmp_path)

        # SNS HTTP is always available (for Terraform/CLI topic creation)
        assert "__sns_http__" in providers

    def test_empty_model_still_has_eventbridge(self, tmp_path):
        app_model = AppModel()
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, _chaos_configs, _ = _create_providers(app_model, graph, config, tmp_path)

        # EventBridge HTTP is always available (for Terraform/CLI event bus creation)
        assert "__events_http__" in providers

    def test_empty_model_still_has_stepfunctions(self, tmp_path):
        app_model = AppModel()
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, _chaos_configs, _ = _create_providers(app_model, graph, config, tmp_path)

        # Step Functions HTTP is always available (for Terraform/CLI state machine creation)
        assert "__stepfunctions_http__" in providers

    def test_empty_model_still_has_cognito(self, tmp_path):
        app_model = AppModel()
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, _chaos_configs, _ = _create_providers(app_model, graph, config, tmp_path)

        # Cognito HTTP is always available (for Terraform/CLI user pool creation)
        assert "__cognito-idp_http__" in providers
