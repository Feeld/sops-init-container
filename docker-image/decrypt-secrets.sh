set -ue
echo "ENCRYPTED_SECRETS_PATH:" $ENCRYPTED_SECRETS_PATH
echo "DECRYPTED_SECRETS_PATH:" $DECRYPTED_SECRETS_PATH

if [ -n "$SOPS_YAML" ]; then
  echo 'creating .sops.yaml from $SOPS_YAML'
  echo "$SOPS_YAML" > .sops.yml
fi

filed_to_process=${ENCRYPTED_SECRETS_PATH}/*

for secret_file in $filed_to_process; do
  echo "decrypting file:" $secret_file
  file_name=$(basename $secret_file)
  sops -d "${secret_file}" > "${DECRYPTED_SECRETS_PATH}/${file_name}"
done

echo "all done!"
