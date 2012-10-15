# Build artifact and its sources/javadoc.
set JAVA_HOME=C:\Progra~1\Java\jdk1.6.0_05
set M2_HOME=D:\Tools\Maven2\maven-2.2.1
set MAVEN_OPTS=-Xmx768M -XX:PermSize=128m -XX:MaxPermSize=128m
%M2_HOME%/bin/mvn clean install -DskipTests -Paddsrc,addjavadoc

