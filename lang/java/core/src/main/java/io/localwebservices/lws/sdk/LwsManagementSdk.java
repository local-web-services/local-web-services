package io.localwebservices.lws.sdk;

import io.localwebservices.lws.cli.LwsCli;
import java.io.IOException;
import java.util.Map;

/** Class-based management SDK wrapping LwsCli. */
public class LwsManagementSdk {

  private final int port;

  public LwsManagementSdk(int port) {
    this.port = port;
  }

  // --- Chaos ---

  public void chaosEnable(String service) throws IOException {
    LwsCli.chaosEnable(port, service);
  }

  public void chaosDisable(String service) throws IOException {
    LwsCli.chaosDisable(port, service);
  }

  public void chaosSet(String service, double errorRate, int latencyMin, int latencyMax)
      throws IOException {
    LwsCli.chaosSet(port, service, errorRate, latencyMin, latencyMax);
  }

  public Map<String, Object> chaosStatus() throws IOException {
    return LwsCli.chaosStatus(port);
  }

  // --- IAM ---

  public void iamSet(String mode) throws IOException {
    LwsCli.iamSet(port, mode);
  }

  public void iamSetIdentity(String identity) throws IOException {
    LwsCli.iamSetIdentity(port, identity);
  }

  public void iamSetModeAndIdentity(String mode, String identity) throws IOException {
    LwsCli.iamSetModeAndIdentity(port, mode, identity);
  }

  public void iamRegisterIdentities(Map<String, Object> identities) throws IOException {
    LwsCli.iamRegisterIdentities(port, identities);
  }

  public Map<String, Object> iamStatus() throws IOException {
    return LwsCli.iamStatus(port);
  }

  // --- Per-service chaos ---

  public void setChaos(String service, double errorRate, int latencyMs) throws IOException {
    LwsCli.setChaos(port, service, errorRate, latencyMs);
  }

  public void resetChaos(String service) throws IOException {
    LwsCli.resetChaos(port, service);
  }

  public Map<String, Object> getChaosStatus(String service) throws IOException {
    return LwsCli.getChaosStatus(port, service);
  }

  // --- State injection ---

  public void injectState(String service, String resourceType, String resourceId, String state)
      throws IOException {
    LwsCli.injectState(port, service, resourceType, resourceId, state);
  }

  public void clearInjectedState(String service, String resourceType, String resourceId)
      throws IOException {
    LwsCli.clearInjectedState(port, service, resourceType, resourceId);
  }

  // --- Fake servers ---

  public void registerFakeServer(String name, String endpoint) throws IOException {
    LwsCli.registerFakeServer(port, name, endpoint);
  }

  public Map<String, Object> listFakeServers() throws IOException {
    return LwsCli.listFakeServers(port);
  }

  // --- Reset ---

  public void reset() throws IOException {
    LwsCli.reset(port);
  }
}
