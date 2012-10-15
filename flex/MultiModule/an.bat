set JAVA_HOME=C:\Progra~1\Java\jdk1.6.0_21
set M2_HOME=D:\Tools\Maven2\maven-2.2.1
set MAVEN_OPTS=-Xmx768M -XX:PermSize=128m -XX:MaxPermSize=128m
rem %M2_HOME%/bin/mvn dependency:analyze
%M2_HOME%/bin/mvn dependency:tree
rem %M2_HOME%/bin/mvn dependency:analyze-dep-mgt -D=ignoreDirect



