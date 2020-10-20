kp image create todos-api --tag registry.mgmt.tanzu.zwickey.net/library/todos-api \
 --git https://gitlab.com/azwickey/todos.git --env BP_MAVEN_BUILT_MODULE=todos-api

kp image create todos-edge --tag registry.mgmt.tanzu.zwickey.net/library/todos-edge \
 --git https://gitlab.com/azwickey/todos.git --env BP_MAVEN_BUILT_MODULE=todos-edge

kp image create todos-postgres --tag registry.mgmt.tanzu.zwickey.net/library/todos-postgres \
 --git https://gitlab.com/azwickey/todos.git --env BP_MAVEN_BUILT_MODULE=todos-postgres

kp image create todos-redis --tag registry.mgmt.tanzu.zwickey.net/library/todos-redis \
 --git https://gitlab.com/azwickey/todos.git --env BP_MAVEN_BUILT_MODULE=todos-redis

kp image create todos-webui --tag registry.mgmt.tanzu.zwickey.net/library/todos-webui \
 --git https://gitlab.com/azwickey/todos.git --env BP_MAVEN_BUILT_MODULE=todos-webui