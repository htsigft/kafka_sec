#!/bin/bash
echo "==================================================================================="
echo "==== Kerberos Client =============================================================="
echo "==================================================================================="
KADMIN_PRINCIPAL_FULL=$KADMIN_PRINCIPAL@$REALM

echo "REALM: $REALM"
echo "KADMIN_PRINCIPAL_FULL: $KADMIN_PRINCIPAL_FULL"
echo "KADMIN_PASSWORD: $KADMIN_PASSWORD"
echo ""

function kadminCommand {
    kadmin -p $KADMIN_PRINCIPAL_FULL -w $KADMIN_PASSWORD -q "$1"
}

echo "==================================================================================="
echo "==== /etc/krb5.conf ==============================================================="
echo "==================================================================================="
tee /etc/krb5.conf <<EOF
[libdefaults]
	default_realm = $REALM
	dns_lookup_realm = false
	dns_lookup_kdc = false
	ticket_lifetime = 24h
	renew_lifetime = 7d
	forwardable = true

[realms]
	$REALM = {
		kdc = kdc-kadmin
		admin_server = kdc-kadmin
	}
EOF
echo ""

cp /etc/krb5.conf /etc/security/keytabs/krb5.conf

echo "==================================================================================="
echo "==== Testing ======================================================================"
echo "==================================================================================="
until kadminCommand "list_principals $KADMIN_PRINCIPAL_FULL"; do
  >&2 echo "KDC is unavailable - sleeping 1 sec"
  sleep 1
done
echo "KDC and Kadmin are operational"
echo ""