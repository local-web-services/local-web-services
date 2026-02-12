from __future__ import annotations

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateDomain:
    def test_create_domain(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        domain_name = "e2e-os-create-domain"
        expected_domain_name = domain_name

        # Act
        result = runner.invoke(
            app,
            [
                "opensearch",
                "create-domain",
                "--domain-name",
                domain_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            ["opensearch", "describe-domain", "--domain-name", domain_name, "--port", str(e2e_port)]
        )
        actual_domain_name = verify["DomainStatus"]["DomainName"]
        assert actual_domain_name == expected_domain_name

    def test_create_and_list_domains(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        domain_name = "e2e-os-create-list"
        lws_invoke(
            [
                "opensearch",
                "create-domain",
                "--domain-name",
                domain_name,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "opensearch",
                "list-domain-names",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["opensearch", "list-domain-names", "--port", str(e2e_port)])
        names = [d["DomainName"] for d in verify["DomainNames"]]
        assert domain_name in names

    def test_create_and_delete_domain(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        domain_name = "e2e-os-create-del"
        lws_invoke(
            [
                "opensearch",
                "create-domain",
                "--domain-name",
                domain_name,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "opensearch",
                "delete-domain",
                "--domain-name",
                domain_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["opensearch", "list-domain-names", "--port", str(e2e_port)])
        names = [d["DomainName"] for d in verify["DomainNames"]]
        assert domain_name not in names
