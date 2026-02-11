"""Tests for Terraform provider creation in ldk dev."""

from __future__ import annotations

from lws.config.loader import LdkConfig


class TestCreateTerraformProviders:
    def test_creates_all_http_providers(self, tmp_path) -> None:
        from lws.cli.ldk import _create_terraform_providers

        config = LdkConfig(port=3000)
        providers, ports = _create_terraform_providers(config, tmp_path)

        assert "__dynamodb_http__" in providers
        assert "__sqs_http__" in providers
        assert "__s3_http__" in providers
        assert "__sns_http__" in providers
        assert "__events_http__" in providers
        assert "__stepfunctions_http__" in providers
        assert "__cognito-idp_http__" in providers
        assert "__apigateway_http__" in providers
        assert "__lambda_http__" in providers
        assert "__iam_http__" in providers
        assert "__sts_http__" in providers

    def test_port_allocation(self, tmp_path) -> None:
        from lws.cli.ldk import _create_terraform_providers

        # Arrange
        expected_dynamodb_port = 4001
        expected_sqs_port = 4002
        expected_s3_port = 4003
        expected_sns_port = 4004
        expected_eventbridge_port = 4005
        expected_stepfunctions_port = 4006
        expected_cognito_port = 4007
        expected_apigateway_port = 4008
        expected_lambda_port = 4009
        expected_iam_port = 4010
        expected_sts_port = 4011
        config = LdkConfig(port=4000)

        # Act
        _, ports = _create_terraform_providers(config, tmp_path)

        # Assert
        assert ports["dynamodb"] == expected_dynamodb_port
        assert ports["sqs"] == expected_sqs_port
        assert ports["s3"] == expected_s3_port
        assert ports["sns"] == expected_sns_port
        assert ports["events"] == expected_eventbridge_port
        assert ports["stepfunctions"] == expected_stepfunctions_port
        assert ports["cognito-idp"] == expected_cognito_port
        assert ports["apigateway"] == expected_apigateway_port
        assert ports["lambda"] == expected_lambda_port
        assert ports["iam"] == expected_iam_port
        assert ports["sts"] == expected_sts_port
