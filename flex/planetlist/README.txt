HOW TO BUILD
________________________________________________________________________________________________________________________

Flash Builder 4:

See pom.xml for required versions. This project can built successfully using Flex SDK 4.0.0.14159. 
The main source folder should be src/main/flex. Also you should add src/main/resources 
and src/test/flex (if you plan to run unit tests).
The additional compiler options are the following:
-locale en_US -allow-source-path-overlap=true -source-path=locale/{locale}

If you want to run tests you should add ASMock 1.0RC (you can download it here http://asmock.sourceforge.net/). 
The required bundle is ASMock with FlexUnit 4 integration which contains two required swc files:
http://sourceforge.net/projects/asmock/files/asmock/asmock-1.0rc/asmock-1.0rc.zip/download

Flex Mojos:

Add the following repositories to Maven's settings.xml or to the Nexus as a proxy repository
(see more details here 
http://www.sonatype.com/books/mvnref-book/reference/installation-sect-details.html#installation-sect-user):
http://repository.sonatype.org/content/groups/flexgroup/

Because of problems with running tests with custom runner ([RunWith] metatag) unit tests can't be run with Flex Mojos.
So now tests are skipped and all the required dependencies are commented. Will try to resolve this issue in future.

THANKS
________________________________________________________________________________________________________________________

Special thanks to Evtim Georgiev (http://evtimmy.com/) for some ideas on implementation 
and Chet Haase (http://graphics-geek.blogspot.com/) 
and his Flex 4 Fun book (http://www.artima.com/shop/flex_4_fun) for some additional info about animations.