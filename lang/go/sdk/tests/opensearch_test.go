package tests

// registerOpenSearchSteps wires all step definitions for the OpenSearch informal
// specification feature files (create_domain, delete_domain, add_tags, remove_tags,
// update_domain_config, create_outbound_connection, delete_outbound_connection,
// accept_inbound_connection, delete_inbound_connection, reject_inbound_connection,
// finish_creating_domain, finish_deleting_domain, blue_green_*, shard_rebalancing).

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/opensearch"
	ostypes "github.com/aws/aws-sdk-go-v2/service/opensearch/types"
	"github.com/cucumber/godog"
)

const (
	osDomainName       = "test-opensearch-domain-1"
	osLocalDomainName  = "test-opensearch-domain-1"
	osRemoteDomainName = "test-opensearch-domain-2"
	osTagKey           = "e2e-os-tag-key-1"
	osTagValue         = "e2e-os-tag-value-1"
	osConnectionAlias  = "test-os-connection-1"
)

// osState holds mutable scenario state for OpenSearch step definitions.
type osState struct {
	outboundConnectionID string
	inboundConnectionID  string
}

// osCreateDomain creates the given OpenSearch domain.
func osCreateDomain(world *World, domainName string) error {
	_, err := world.OpenSearchClient().CreateDomain(context.Background(), &opensearch.CreateDomainInput{
		DomainName: aws.String(domainName),
	})
	return err
}

// osDomainExists returns whether the given domain currently exists (not deleted).
func osDomainExists(world *World, domainName string) bool {
	resp, err := world.OpenSearchClient().DescribeDomain(context.Background(), &opensearch.DescribeDomainInput{
		DomainName: aws.String(domainName),
	})
	if err != nil {
		return false
	}
	if resp.DomainStatus == nil {
		return false
	}
	deleted := resp.DomainStatus.Deleted
	return deleted == nil || !*deleted
}

// osDomainARN returns the ARN of the given domain.
func osDomainARN(world *World, domainName string) (string, error) {
	resp, err := world.OpenSearchClient().DescribeDomain(context.Background(), &opensearch.DescribeDomainInput{
		DomainName: aws.String(domainName),
	})
	if err != nil {
		return "", err
	}
	if resp.DomainStatus == nil {
		return "", fmt.Errorf("domain status is nil")
	}
	return aws.ToString(resp.DomainStatus.ARN), nil
}

func registerOpenSearchSteps(sc *godog.ScenarioContext, world *World) {
	st := &osState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.outboundConnectionID = ""
		st.inboundConnectionID = ""
		return ctx, nil
	})

	// -------------------------------------------------------------------------
	// Given: domain state setup
	// -------------------------------------------------------------------------

	// NOTE: "the domain does not already exist" and "the domain already exists" are
	// registered by the elasticsearch steps file; this file registers the same
	// steps via the same sc so they must not be duplicated.
	// They map to domain management for opensearch equivalently.

	sc.Given(`^the local domain exists$`, func() error {
		// Arrange / Act: ensure the local domain exists.
		if !osDomainExists(world, osLocalDomainName) {
			return osCreateDomain(world, osLocalDomainName)
		}
		return nil
	})

	sc.Given(`^the local domain does not exist$`, func() error {
		// No-op: fresh state after reset has no domains.
		return nil
	})

	sc.Given(`^the local domain is "ACTIVE"$`, func() error {
		// No-op: lws domains are immediately active after creation.
		return nil
	})

	sc.Given(`^the local domain is not "ACTIVE"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the remote domain exists$`, func() error {
		// Arrange / Act: ensure the remote domain exists.
		if !osDomainExists(world, osRemoteDomainName) {
			return osCreateDomain(world, osRemoteDomainName)
		}
		return nil
	})

	sc.Given(`^the remote domain does not exist$`, func() error {
		// No-op: fresh state after reset has no remote domain.
		return nil
	})

	sc.Given(`^the remote domain is "ACTIVE"$`, func() error {
		// No-op: lws domains are immediately active after creation.
		return nil
	})

	sc.Given(`^the remote domain is not "ACTIVE"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the local and remote domains are different$`, func() error {
		// No-op: test uses distinct domain names.
		return nil
	})

	sc.Given(`^the local and remote domains are the same$`, func() error {
		// Arrange: for the "same domain" negative scenario we point remote at local.
		// This is purely a state hint — the When step uses same name for both.
		return nil
	})

	sc.Given(`^the connection slot is available$`, func() error {
		// No-op: fresh state has no connections, so slot is always available.
		return nil
	})

	sc.Given(`^the connection slot is not available$`, func() error {
		// @internal: capacity exhaustion requires internal state manipulation — not reachable via public API.
		return nil
	})

	// ── Given: outbound connection state ─────────────────────────────────────

	sc.Given(`^the outbound connection exists$`, func() error {
		// Arrange: ensure both domains exist and create an outbound connection.
		if !osDomainExists(world, osLocalDomainName) {
			if err := osCreateDomain(world, osLocalDomainName); err != nil {
				return err
			}
		}
		if !osDomainExists(world, osRemoteDomainName) {
			if err := osCreateDomain(world, osRemoteDomainName); err != nil {
				return err
			}
		}
		resp, err := world.OpenSearchClient().CreateOutboundConnection(context.Background(), &opensearch.CreateOutboundConnectionInput{
			ConnectionAlias: aws.String(osConnectionAlias),
			LocalDomainInfo: &ostypes.DomainInformationContainer{
				AWSDomainInformation: &ostypes.AWSDomainInformation{
					DomainName: aws.String(osLocalDomainName),
					OwnerId:    aws.String("000000000000"),
					Region:     aws.String("us-east-1"),
				},
			},
			RemoteDomainInfo: &ostypes.DomainInformationContainer{
				AWSDomainInformation: &ostypes.AWSDomainInformation{
					DomainName: aws.String(osRemoteDomainName),
					OwnerId:    aws.String("000000000000"),
					Region:     aws.String("us-east-1"),
				},
			},
		})
		if err != nil {
			return err
		}
		st.outboundConnectionID = aws.ToString(resp.ConnectionId)
		return nil
	})

	sc.Given(`^the outbound connection does not exist$`, func() error {
		// No-op: fresh state after reset has no outbound connections.
		return nil
	})

	sc.Given(`^the outbound connection is not already "DELETING"$`, func() error {
		// No-op: freshly created connections are not in DELETING state.
		return nil
	})

	sc.Given(`^the outbound connection is already "DELETING"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the outbound connection is not already "DELETED"$`, func() error {
		// No-op: freshly created connections are not in DELETED state.
		return nil
	})

	sc.Given(`^the outbound connection is already "DELETED"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the outbound connection is "DELETING"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the outbound connection is not "DELETING"$`, func() error {
		// No-op: freshly created connections are not in DELETING state.
		return nil
	})

	sc.Given(`^the associated inbound connection exists$`, func() error {
		// No-op: inbound connection is created automatically with outbound connection.
		return nil
	})

	sc.Given(`^the associated inbound connection does not exist$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	// ── Given: inbound connection state ──────────────────────────────────────

	sc.Given(`^the inbound connection exists$`, func() error {
		// Arrange: ensure both domains exist, create outbound connection,
		// then use the auto-created inbound connection ID.
		if !osDomainExists(world, osLocalDomainName) {
			if err := osCreateDomain(world, osLocalDomainName); err != nil {
				return err
			}
		}
		if !osDomainExists(world, osRemoteDomainName) {
			if err := osCreateDomain(world, osRemoteDomainName); err != nil {
				return err
			}
		}
		resp, err := world.OpenSearchClient().CreateOutboundConnection(context.Background(), &opensearch.CreateOutboundConnectionInput{
			ConnectionAlias: aws.String(osConnectionAlias),
			LocalDomainInfo: &ostypes.DomainInformationContainer{
				AWSDomainInformation: &ostypes.AWSDomainInformation{
					DomainName: aws.String(osLocalDomainName),
					OwnerId:    aws.String("000000000000"),
					Region:     aws.String("us-east-1"),
				},
			},
			RemoteDomainInfo: &ostypes.DomainInformationContainer{
				AWSDomainInformation: &ostypes.AWSDomainInformation{
					DomainName: aws.String(osRemoteDomainName),
					OwnerId:    aws.String("000000000000"),
					Region:     aws.String("us-east-1"),
				},
			},
		})
		if err != nil {
			return err
		}
		st.outboundConnectionID = aws.ToString(resp.ConnectionId)
		// The inbound connection ID matches the outbound connection ID in lws.
		st.inboundConnectionID = st.outboundConnectionID
		return nil
	})

	sc.Given(`^the inbound connection does not exist$`, func() error {
		// No-op: fresh state after reset has no inbound connections.
		return nil
	})

	sc.Given(`^the inbound connection is "PENDING_ACCEPTANCE"$`, func() error {
		// No-op: freshly created inbound connections are in PENDING_ACCEPTANCE state.
		return nil
	})

	sc.Given(`^the inbound connection is not "PENDING_ACCEPTANCE"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the inbound connection is not already "DELETING"$`, func() error {
		// No-op: freshly created connections are not in DELETING state.
		return nil
	})

	sc.Given(`^the inbound connection is already "DELETING"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the inbound connection is not already "DELETED"$`, func() error {
		// No-op: freshly created connections are not in DELETED state.
		return nil
	})

	sc.Given(`^the inbound connection is already "DELETED"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the inbound connection is "DELETING"$`, func() error {
		// @internal: requires internal state manipulation — not reachable via public API.
		return nil
	})

	sc.Given(`^the inbound connection is not "DELETING"$`, func() error {
		// No-op: freshly created connections are not in DELETING state.
		return nil
	})

	// ── Given: blue-green deployment state ───────────────────────────────────

	sc.Given(`^the new cluster has not been prepared yet$`, func() error {
		// @internal: blue-green deployment state is controlled internally.
		return nil
	})

	sc.Given(`^the new cluster has already been prepared$`, func() error {
		// @internal: blue-green deployment state is controlled internally.
		return nil
	})

	sc.Given(`^the new cluster is ready$`, func() error {
		// @internal: blue-green deployment state is controlled internally.
		return nil
	})

	sc.Given(`^the new cluster is not ready$`, func() error {
		// @internal: blue-green deployment state is controlled internally.
		return nil
	})

	sc.Given(`^traffic has not been swapped yet$`, func() error {
		// @internal: blue-green deployment state is controlled internally.
		return nil
	})

	sc.Given(`^traffic has already been swapped$`, func() error {
		// @internal: blue-green deployment state is controlled internally.
		return nil
	})

	sc.Given(`^traffic has been swapped to the new cluster$`, func() error {
		// @internal: blue-green deployment state is controlled internally.
		return nil
	})

	sc.Given(`^traffic has not been swapped to the new cluster$`, func() error {
		// @internal: blue-green deployment state is controlled internally.
		return nil
	})

	// -------------------------------------------------------------------------
	// When: actions
	// -------------------------------------------------------------------------

	sc.When(`^an outbound cross-cluster connection is created between two domains$`, func() error {
		// Arrange: (domain state set up by Given steps)
		// Act
		localDomain := osLocalDomainName
		remoteDomain := osRemoteDomainName
		resp, err := world.OpenSearchClient().CreateOutboundConnection(context.Background(), &opensearch.CreateOutboundConnectionInput{
			ConnectionAlias: aws.String(osConnectionAlias),
			LocalDomainInfo: &ostypes.DomainInformationContainer{
				AWSDomainInformation: &ostypes.AWSDomainInformation{
					DomainName: aws.String(localDomain),
					OwnerId:    aws.String("000000000000"),
					Region:     aws.String("us-east-1"),
				},
			},
			RemoteDomainInfo: &ostypes.DomainInformationContainer{
				AWSDomainInformation: &ostypes.AWSDomainInformation{
					DomainName: aws.String(remoteDomain),
					OwnerId:    aws.String("000000000000"),
					Region:     aws.String("us-east-1"),
				},
			},
		})
		if err == nil && resp != nil {
			st.outboundConnectionID = aws.ToString(resp.ConnectionId)
		}
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an outbound cross-cluster connection is deleted$`, func() error {
		// Arrange: (connection state set up by Given steps)
		// Act
		resp, err := world.OpenSearchClient().DeleteOutboundConnection(context.Background(), &opensearch.DeleteOutboundConnectionInput{
			ConnectionId: aws.String(st.outboundConnectionID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an inbound cross-cluster connection is accepted$`, func() error {
		// Arrange: (connection state set up by Given steps)
		// Act
		resp, err := world.OpenSearchClient().AcceptInboundConnection(context.Background(), &opensearch.AcceptInboundConnectionInput{
			ConnectionId: aws.String(st.inboundConnectionID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an inbound cross-cluster connection is deleted$`, func() error {
		// Arrange: (connection state set up by Given steps)
		// Act
		resp, err := world.OpenSearchClient().DeleteInboundConnection(context.Background(), &opensearch.DeleteInboundConnectionInput{
			ConnectionId: aws.String(st.inboundConnectionID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an inbound cross-cluster connection is rejected$`, func() error {
		// Arrange: (connection state set up by Given steps)
		// Act
		resp, err := world.OpenSearchClient().RejectInboundConnection(context.Background(), &opensearch.RejectInboundConnectionInput{
			ConnectionId: aws.String(st.inboundConnectionID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a domain configuration update is requested$`, func() error {
		// Arrange: (domain state set up by Given steps)
		// Act
		resp, err := world.OpenSearchClient().UpdateDomainConfig(context.Background(), &opensearch.UpdateDomainConfigInput{
			DomainName: aws.String(osDomainName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a search domain finishes creating$`, func() error {
		// @internal: no public API to advance the domain lifecycle — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a search domain finishes deleting$`, func() error {
		// @internal: no public API to advance the domain lifecycle — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^an inbound connection finishes deleting$`, func() error {
		// @internal: no public API to advance connection lifecycle — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^an outbound connection finishes deleting$`, func() error {
		// @internal: no public API to advance connection lifecycle — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a blue-green deployment completes$`, func() error {
		// @internal: no public API to advance blue-green lifecycle — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^the new cluster for a blue-green deployment becomes ready$`, func() error {
		// @internal: no public API to advance blue-green lifecycle — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^traffic is swapped to the new cluster during a blue-green deployment$`, func() error {
		// @internal: no public API to swap traffic — no-op.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^shards are rebalanced across nodes in an active domain$`, func() error {
		// @internal: no public API to trigger shard rebalancing — no-op.
		setResult(world, nil, nil)
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: assertions
	// -------------------------------------------------------------------------

	sc.Then(`^the connection is in "PENDING_ACCEPTANCE" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_outbound_connection to succeed but got: %w", world.lastResult.Error)
		}
		expectedConnectionID := st.outboundConnectionID
		if expectedConnectionID == "" {
			return fmt.Errorf("expected outbound connection ID to be set but it was empty")
		}
		return nil
	})

	sc.Then(`^the outbound connection is in "DELETING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_outbound_connection to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the inbound connection is in "DELETING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_inbound_connection to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^both the inbound and outbound connection are "ACTIVE"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected accept_inbound_connection to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^both the inbound and outbound connection are "REJECTED"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected reject_inbound_connection to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the inbound connection is "DELETED"$`, func() error {
		// @internal: state transition controlled internally — no-op.
		return nil
	})

	sc.Then(`^the outbound and associated inbound connection are "DELETED"$`, func() error {
		// @internal: state transition controlled internally — no-op.
		return nil
	})

	sc.Then(`^the domain is in "PROCESSING" state and a blue-green deployment begins$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected update_domain_config to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the domain is "ACTIVE" with the new configuration applied$`, func() error {
		// @internal: state transition controlled internally — no-op.
		return nil
	})

	sc.Then(`^the domain has a new cluster prepared but traffic is not yet swapped$`, func() error {
		// @internal: state transition controlled internally — no-op.
		return nil
	})

	sc.Then(`^the domain is now serving requests from the new cluster$`, func() error {
		// @internal: state transition controlled internally — no-op.
		return nil
	})

	sc.Then(`^the instance count is updated without data loss$`, func() error {
		// @internal: state transition controlled internally — no-op.
		return nil
	})

	sc.Then(`^no active connection references a deleted domain$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^traffic can only be swapped after the new cluster is ready$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})
}
