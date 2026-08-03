-- Disable HTTPS on port 5281
https_ports = {}

-- Enable Direct-TLS on port 5223
c2s_direct_tls_ports = { 5223 }

-- The direct-TLS listener needs its own certificate (XEP-0368). STARTTLS picks
-- the per-host cert from the stream header via SNI, but the immediate-TLS socket
-- falls back to the global 'ssl' option, which is not set here — so without this
-- it answers every handshake with a TLS alert. Point it at the domain cert.
c2s_direct_tls_ssl = {
    certificate = "/etc/yunohost/certs/__DOMAIN__/crt.pem";
    key = "/etc/yunohost/certs/__DOMAIN__/key.pem";
}
