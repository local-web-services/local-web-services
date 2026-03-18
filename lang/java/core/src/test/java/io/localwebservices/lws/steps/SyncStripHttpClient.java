package io.localwebservices.lws.steps;

import java.net.URI;
import java.net.URISyntaxException;
import software.amazon.awssdk.http.*;

/**
 * A delegating SdkHttpClient that strips "sync-" prefix from hostnames. This is needed because the
 * AWS SDK v2 SFN client prepends "sync-" to the hostname for StartSyncExecution calls via endpoint
 * variant resolution, even when endpointOverride is set.
 */
public class SyncStripHttpClient implements SdkHttpClient {

  private final SdkHttpClient delegate;

  public SyncStripHttpClient(SdkHttpClient delegate) {
    this.delegate = delegate;
  }

  @Override
  public ExecutableHttpRequest prepareRequest(HttpExecuteRequest request) {
    SdkHttpRequest originalRequest = request.httpRequest();
    URI originalUri = originalRequest.getUri();
    String host = originalUri.getHost();

    if (host != null && host.startsWith("sync-")) {
      String newHost = host.substring("sync-".length());
      try {
        URI newUri =
            new URI(
                originalUri.getScheme(),
                originalUri.getUserInfo(),
                newHost,
                originalUri.getPort(),
                originalUri.getPath(),
                originalUri.getQuery(),
                originalUri.getFragment());
        SdkHttpRequest newRequest = originalRequest.toBuilder().uri(newUri).build();
        HttpExecuteRequest newExecuteRequest =
            HttpExecuteRequest.builder()
                .request(newRequest)
                .contentStreamProvider(request.contentStreamProvider().orElse(null))
                .build();
        return delegate.prepareRequest(newExecuteRequest);
      } catch (URISyntaxException e) {
        // Fall through to delegate with original request
      }
    }

    return delegate.prepareRequest(request);
  }

  @Override
  public void close() {
    delegate.close();
  }

  @Override
  public String clientName() {
    return "SyncStripHttpClient(" + delegate.clientName() + ")";
  }
}
