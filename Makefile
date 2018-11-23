APP_PATH=/Applications/企业微信.app/Contents/MacOS
APP_NAME=企业微信
BACKUP_NAME=企业微信.bak
FRAMEWORK_PATH=WEWTweak.framework
FRAMEWORK_NAME=WEWTweak

debug::
	DYLD_INSERT_LIBRARIES=${FRAMEWORK_PATH}/${FRAMEWORK_NAME} ${APP_PATH}/${APP_NAME} &

install::
	@if ! [[ $EUID -eq 0 ]]; then\
    	echo "😢 This script should be run using sudo or as the root user.";\
    	exit 1;\
	fi
	@if ! [ -f "${APP_PATH}/${APP_NAME}" ]; then\
		echo "😢 Can not find ${APP_NAME}.";\
		exit 1;\
	fi
	@if ! [ -d "${FRAMEWORK_PATH}" ]; then\
		echo "⚠️ Can not find ${FRAMEWORK_PATH}, please build first.";\
		exit 1;\
	fi
	@if [ -d "${APP_PATH}/${FRAMEWORK_PATH}" ]; then\
		rm -rf ${APP_PATH}/${FRAMEWORK_PATH};\
		cp -R ${FRAMEWORK_PATH} ${APP_PATH};\
		echo "✅ Replaced the old framework with the new one, install success.";\
	else \
		cp ${APP_PATH}/${APP_NAME} ${APP_PATH}/${BACKUP_NAME};\
		cp -R ${FRAMEWORK_PATH} ${APP_PATH};\
		./insert_dylib @executable_path/${FRAMEWORK_PATH}/${FRAMEWORK_NAME} ${APP_PATH}/${APP_NAME} ${APP_PATH}/${APP_NAME} --all-yes;\
		echo "✅ Install success.";\
	fi

uninstall::
	@if ! [[ $EUID -eq 0 ]]; then\
    	echo "😢 This script should be run using sudo or as the root user.";\
    	exit 1;\
	fi
	@if ! [ -f "${APP_PATH}/${APP_NAME}" ]; then\
		echo "😢 Can not find ${APP_NAME}.";\
		exit 1;\
	fi
	@if ! [ -f "${APP_PATH}/${BACKUP_NAME}" ]; then\
		echo "😢 Can not find ${BACKUP_NAME}.";\
		exit 1;\
	fi

	@rm -rf ${APP_PATH}/${FRAMEWORK_PATH};
	@mv ${APP_PATH}/${BACKUP_NAME} ${APP_PATH}/${APP_NAME};
	@echo "✅ Uninstall success";

clean::
	rm -rf ${FRAMEWORK_PATH}
