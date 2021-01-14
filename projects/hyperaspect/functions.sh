function hyper_jwt_user {
  echo "User ID: "
  echo -n "$1" | cut -d'.' -f2 | base64 -d | jq .userId -r
}
