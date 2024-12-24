build-GemLayer:
	cp Gemfile* $(ARTIFACTS_DIR)
	cd $(ARTIFACTS_DIR) \
		&& bundle config set deployment 'true' \
		&& bundle config set without 'development test' \
		&& bundle config set path $(ARTIFACTS_DIR) \
		&& bundle config set no-cache 'true' \
		&& bundle install
	find $(ARTIFACTS_DIR) -type f -name '*.c' -delete
	find $(ARTIFACTS_DIR) -type f -name '*.h' -delete
	find $(ARTIFACTS_DIR) -type f -name '*.o' -delete
	find $(ARTIFACTS_DIR) -type f -name '*.gem' -delete
	rm $(ARTIFACTS_DIR)/Gemfile*

build-%:
	rsync --exclude-from .rsyncignore -a . $(ARTIFACTS_DIR)
	cd $(ARTIFACTS_DIR) \
		&& bundle config set path /opt \
		&& bundle config set deployment 'true' \
		&& bundle config set without 'development test'

build:
	sam build

invoke-%: build
	sam local invoke $*Function --event events/$*.json

deploy: build
	sam deploy
