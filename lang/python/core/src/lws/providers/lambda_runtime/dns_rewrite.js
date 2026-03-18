/**
 * DNS rewrite hook for Docker-based Lambda functions.
 *
 * Virtual-hosted-style S3 requests produce hostnames like
 * "bucket-name.host.docker.internal" which cannot be resolved by Docker's
 * built-in DNS. This preload script patches Node's dns.lookup so that any
 * subdomain of host.docker.internal resolves to host.docker.internal itself,
 * allowing the request to reach the LWS S3 server on the host.
 *
 * Loaded via NODE_OPTIONS=--require /var/bootstrap/dns_rewrite.js
 */
'use strict';

var dns = require('dns');
var origLookup = dns.lookup;

dns.lookup = function(hostname, options, callback) {
  if (typeof options === 'function') {
    callback = options;
    options = {};
  }
  if (typeof hostname === 'string' &&
      hostname.endsWith('.host.docker.internal') &&
      hostname !== 'host.docker.internal') {
    hostname = 'host.docker.internal';
  }
  return origLookup.call(this, hostname, options, callback);
};
