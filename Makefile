define uninstall
	rm -rf /usr/bin/yap /usr/local/lib/bash/5.17/yap
endef

install:
	@bash ./install.sh

uninstall:
	$(uninstall)

reinstall:
	$(uninstall)
	@bash ./install.sh