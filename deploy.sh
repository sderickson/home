npm run build-prod
docker build -t sderickson/home .
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
docker push sderickson/home:latest