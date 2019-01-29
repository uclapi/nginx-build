docker rm uclapi-nginx-build

$pwd = Get-Location
docker build -t uclapi-nginx-build .
docker run -it -v $pwd\builds:/builds --rm uclapi-nginx-build
