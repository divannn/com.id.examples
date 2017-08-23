Shows how to use repo inside maven project.

1) declare new repo in pom.xml

2) push lib.txt file to local repo
mvn deploy:deploy-file -Durl=file://C:\Users\danili\Dropbox\src\maven\LocalRepo\repo -Dfile=lib.txt -DgroupId=com.example -DartifactId=mylib -Dpackaging=txt -Dversion=1.0 

3) use dependency to this artifact as usual
In this example - just use maven to copy it in default target/dependency folder
