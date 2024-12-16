bundler-config:
	bundle config set deployment 'true'
	bundle config set without 'development test'

build-GemLayer: bundler-config
	bundle config set path $(ARTIFACTS_DIR)
	bundle config set no-cache 'true'
	bundle install
	find $(ARTIFACTS_DIR) -type f -name '*.c' -delete
	find $(ARTIFACTS_DIR) -type f -name '*.h' -delete
	find $(ARTIFACTS_DIR) -type f -name '*.o' -delete
	find $(ARTIFACTS_DIR) -type f -name '*.gem' -delete

build-FetcherFunction:
	rsync --exclude-from .rsyncignore -a . $(ARTIFACTS_DIR)
