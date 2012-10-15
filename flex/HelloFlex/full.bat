set JAVA_HOME=D:\Tools\Java\jdk1.6.0_26
set M2_HOME=D:\Tools\Maven2\maven-2.2.1
set FP=D:\Dist\Flex\FP\flashplayer_10_sa_debug.exe
%M2_HOME%/bin/mvn clean install -DconfigurationReport=true -DflashPlayer.command=%FP% -Padd-src,add-asdoc
rem -Dmaven.test.skip=true