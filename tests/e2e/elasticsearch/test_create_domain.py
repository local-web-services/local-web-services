from __future__ import annotations

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateElasticsearchDomain:
    def test_create_elasticsearch_domain(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        domain_name = "e2e-es-create-domain"
        expected_domain_name = domain_name

        # Act
        result = runner.invoke(
            app,
            [
                "es",
                "create-elasticsearch-domain",
                "--domain-name",
                domain_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            [
                "es",
                "describe-elasticsearch-domain",
                "--domain-name",
                domain_name,
                "--port",
                str(e2e_port),
            ]
        )
        actual_domain_name = verify["DomainStatus"]["DomainName"]
        assert actual_domain_name == expected_domain_name

    def test_create_and_list_domains(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        domain_name = "e2e-es-create-list"
        lws_invoke(
            [
                "es",
                "create-elasticsearch-domain",
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
                "es",
                "list-domain-names",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["es", "list-domain-names", "--port", str(e2e_port)])
        names = [d["DomainName"] for d in verify["DomainNames"]]
        assert domain_name in names

    def test_create_and_delete_domain(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        domain_name = "e2e-es-create-del"
        lws_invoke(
            [
                "es",
                "create-elasticsearch-domain",
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
                "es",
                "delete-elasticsearch-domain",
                "--domain-name",
                domain_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["es", "list-domain-names", "--port", str(e2e_port)])
        names = [d["DomainName"] for d in verify["DomainNames"]]
        assert domain_name not in names
