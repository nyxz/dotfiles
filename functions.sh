
function testSitePrefix {
  # Usage: testSitePrefix placementfeed.co.uk
  local prefixes=( '' 'www.' 'http://www.' 'http://' 'https://www.' 'https://' )
  for prefix in "${prefixes[@]}"
  do
    fullUrl=$prefix"$1"
    printf "--------------------------------------------------\n"
    printf "Testing $fullUrl\n"
    printf "--------------------------------------------------\n"
    curl -I $fullUrl
  done
}

function sha2base {
  sha256sum $1 | head -c 64 | xxd -r -p | base64
}

function gitRevertDeletedFile {
  local file=$1
  git checkout $(git rev-list -n 1 HEAD -- "$file")^ -- "$file"
}

function backup {
  if [ $# != 1 ]; then
    echo "Give filename or directory."
    return 1
  fi
  cp -r $1{,.BAK.`date +%Y-%m-%d.%H-%M-%S`}
  return 0
}

function goto {
  cd $1 && git status
}

function awsListImageVersions {
  local repository_name="$1"
  aws ecr list-images --repository-name "$repository_name" | jq -r '.imageIds[] | .imageTag' | sort -r
}

