#!/usr/bin/env bash
version=$1
reg_port=5050
echo building $version
podman image rm us/container:${version} || true
podman manifest rm us/container:${version} || true
# image_id=$(podman manifest create us/container:${version})
# echo DIGEST $image_id
podman build --platform linux/amd64,linux/arm64  --manifest us/container:${version} container
image_id=$(podman image inspect us/container/universal-syslog:0.0.2 --format '{{.Digest}}')
podman manifest push us/container:${version} 127.0.0.1:$reg_port/us/container/universal-syslog:${version} --tls-verify=false
mkdir .charts || true
rm -rf .charts/* || true
helm package charts/universal-syslog --app-version $version --version $version --destination .charts/

TMPFILE=$(mktemp /tmp/helm-output.XXXXXX)
function cleanup() {
  rm -f "${TMPFILE}"
}
trap cleanup err
trap "rm -f $TMPFILE" exit
helm push .charts/universal-syslog-${version}.tgz oci://127.0.0.1:$reg_port/us/chart --plain-http &>${TMPFILE}
helm_digest=$(cat $TMPFILE | grep 'Digest' | awk '{print $2}')
cat ${TMPFILE}
echo "Extracted Digest: ${helm_digest}"

kubectl -n universal-syslog delete helmrelease universal-syslog-default
pushd .kind/bootstrap
terraform apply -auto-approve \
    -var universal_syslog_image_tag=$version \
    -var universal_syslog_chart_tag=$version 

echo DIGEST $version
#@sha256:$image_id 
popd