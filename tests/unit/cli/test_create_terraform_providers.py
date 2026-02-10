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
        assert "__eventbridge_http__" in providers
        assert "__stepfunctions_http__" in providers
        assert "__cognito_http__" in providers
        assert "__apigateway_http__" in providers
        assert "__lambda_http__" in providers
        assert "__iam_http__" in providers
        assert "__sts_http__" in providers

    def test_port_allocation(self, tmp_path) -> None:
        from lws.cli.ldk import _create_terraform_providers

        config = LdkConfig(port=4000)
        _, ports = _create_terraform_providers(config, tmp_path)

        assert ports["dynamodb"] == 4001
        assert ports["sqs"] == 4002
        assert ports["s3"] == 4003
        assert ports["sns"] == 4004
        assert ports["eventbridge"] == 4005
        assert ports["stepfunctions"] == 4006
        assert ports["cognito"] == 4007
        assert ports["apigateway"] == 4008
        assert ports["lambda"] == 4009
        assert ports["iam"] == 4010
        assert ports["sts"] == 4011
