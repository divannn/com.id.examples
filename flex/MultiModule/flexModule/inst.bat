set JAVA_HOME=C:\Progra~1\Java\jdk1.6.0_21
set M2_HOME=D:\Tools\Maven2\maven-2.2.1
set FP=D:\Dist\Flex\FP\flashplayer_10_sa_debug.exe
%M2_HOME%/bin/mvn clean install -DconfigurationReport=true -DflashPlayer.command=%FP% -Dmaven.test.skip=true