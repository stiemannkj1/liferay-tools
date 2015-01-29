#!/bin/sh

curl -s "http://localhost:8080/web/guest/showcase/-/component/aui/datepicker/general" > /dev/null 
curl -s "http://localhost:8080/web/guest/showcase?p_p_id=1_WAR_showcaseportlet&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_count=1&_1_WAR_showcaseportlet__jsfBridgeAjax=true&_1_WAR_showcaseportlet__facesViewIdResource=%2Fviews%2Fcomponent.xhtml&_1_WAR_showcaseportlet_componentUseCase=general&_1_WAR_showcaseportlet_componentName=datepicker&_1_WAR_showcaseportlet_componentPrefix=aui"
