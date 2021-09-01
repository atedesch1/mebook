deploy: check-uncommited-changes
	@git push
	-git tag -d prod
	-git push --delete origin prod
	git tag prod
	git push origin prod

test:
	go test --short --race -v -coverprofile=coverage.out ./...

check-uncommited-changes:
	git update-index --refresh
	git diff-index --quiet HEAD --
